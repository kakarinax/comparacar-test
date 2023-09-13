require 'rails_helper'

RSpec.describe Types::QueryType, type: :request do
  let(:request) { post '/graphql', params: { query: } }

  describe 'cars' do
    context 'when finds all cars' do
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

    context 'when does not find any car' do
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
    context 'when finds a car' do
      let!(:car) { create(:car) }

      let(:query) do
        <<~GQL
          query {
            car(id: "#{car.id}") {
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

    context 'when does not find a car' do
      let(:query) do
        <<~GQL
          query {
            car(id: "5d2d4e7c8f1b5c0b3b6e1b4f") {
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
end
