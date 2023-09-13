require 'rails_helper'

RSpec.describe Types::QueryType, type: :request do
  let(:request) { post '/graphql', params: { query: } }
  let(:red_cars) { create_list(:car, 3, color: 'red') }
  let(:kms_cars) { create_list(:car, 3, kms: 1000) }
  let(:valid_car_id) { car.id.to_s }
  let(:invalid_car_id) { BSON::ObjectId.new.to_s }

  describe 'cars' do
    context 'when finding all cars' do
      let!(:cars) { create_list(:car, 3) }

      let(:query) do
        <<~GQL
          query {
            cars {
              id
              color
              kms
              version {
                name
                year
              }
            }
          }
        GQL
      end

      before do
        request
      end

      it 'returns all cars' do
        data = JSON.parse(response.body)['data']['cars']

        expect(data).to match_array(
          cars.map { |car| include('id' => car.id.to_s) }
        )
      end
    end

    context 'when not finding any car' do
      let(:query) do
        <<~GQL
          query {
            cars {
              id
              color
              kms
              version {
                name
                year
              }
            }
          }
        GQL
      end

      before do
        request
      end

      it 'returns empty array' do
        data = JSON.parse(response.body)['data']['cars']
        expect(data).to be_empty
      end
    end
  end

  describe 'car' do
    context 'when finding a car' do
      let!(:car) { create(:car) }

      let(:query) do
        <<~GQL
          query {
            car(id: "#{valid_car_id}") {
              id
              color
              kms
              version {
                name
                year
              }
            }
          }
        GQL
      end

      before do
        request
      end

      it 'returns a car' do
        data = JSON.parse(response.body)['data']['car']
        expect(data).to include(
          'id' => car.id.to_s,
          'color' => car.color,
          'kms' => car.kms,
          'version' => {
            'name' => car.version.name,
            'year' => car.version.year
          }
        )
      end
    end

    context 'when not finding a car' do
      let(:query) do
        <<~GQL
          query {
            car(id: "#{invalid_car_id}") {
              id
              color
              kms
              version {
                name
                year
              }
            }
          }
        GQL
      end

      before do
        request
      end

      it 'returns an error' do
        data = JSON.parse(response.body)['errors']
        expect(data).not_to be_empty
      end
    end
  end

  describe 'cars_by_color' do
    context 'when finding cars by color' do
      let(:query) do
        <<~GQL
          query {
            carsByColor(color: "red") {
              id
              color
              kms
              version {
                name
                year
              }
            }
          }
        GQL
      end

      before do
        red_cars
        request
      end

      it 'returns cars by color' do
        data = JSON.parse(response.body)['data']['carsByColor']

        expect(data.size).to eq(3)
      end
    end
  end

  describe 'cars_by_kms' do
    context 'when finding cars by kms' do
      let(:query) do
        <<~GQL
          query {
            carsByKms(kms: 1000) {
              id
              color
              kms
              version {
                name
                year
              }
            }
          }
        GQL
      end

      before do
        kms_cars
        request
      end

      it 'returns cars by kms' do
        data = JSON.parse(response.body)['data']['carsByKms']

        expect(data.size).to eq(3)
      end
    end
  end
end
