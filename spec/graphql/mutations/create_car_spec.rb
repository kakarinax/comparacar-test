require 'rails_helper'

RSpec.describe Mutations::CreateCar, type: :request do
  describe '.resolve' do
    context 'when creates a car sucessfully' do
      let(:request) { post '/graphql', params: { query: } }

      let(:query) do
        <<~GQL
          mutation {
            createCar(input: {
              color: "red"
              kms: 10000
              version: {
                name: "some version"
                year: 2018
              }
            }) {
              car {
                id
                color
                kms
                version {
                  name
                  year
                }
              }
              errors
            }
          }
        GQL
      end

      before do
        request
      end

      it 'creates a car' do
        expect(Car.count).to eq(1)
      end

      it 'embeds a version' do
        car = Car.last
        expect(car.version).to be_present
      end

      it 'returns a car' do
        data = JSON.parse(response.body)['data']['createCar']['car']

        expect(data).to include(
          'id' => be_present,
          'color' => 'red',
          'kms' => 10_000,
          'version' => {
            'name' => 'some version',
            'year' => 2018
          }
        )
      end

      it 'zero errors' do
        data = JSON.parse(response.body)['data']['createCar']['errors']
        expect(data).to be_empty
      end
    end

    context 'when there is an error' do
      let(:request) { post '/graphql', params: { query: } }

      let(:query) do
        <<~GQL
          mutation {
            createCar(input: {
              color: "red"
              kms: "some kms"
              version: {
                name: "some version"
                year: 2018
              }
            }) {
              car {
                id
                color
                kms
                version {
                  name
                  year
                }
              }
              errors
            }
          }
        GQL
      end

      before do
        request
      end

      it 'does not create a car' do
        expect(Car.count).to eq(0)
      end

      it 'throws an error' do
        data = JSON.parse(response.body)['errors']
        expect(data).not_to be_empty
      end
    end
  end
end
