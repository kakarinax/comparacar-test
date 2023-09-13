require 'rails_helper'

RSpec.describe Mutations::DeleteCar, type: :request do
  describe '.resolve' do
    let(:request) { post '/graphql', params: { query: } }

    context 'when deletes a car sucessfully' do
      let!(:car) { create(:car) }

      let(:query) do
        <<~GQL
          mutation {
            deleteCar(input: {
              id: "#{car.id}"
            }) {
              car {
                id
              }
            }
          }
        GQL
      end

      before do
        request
      end

      it 'deletes a car' do
        expect(Car.count).to eq(0)
      end

      it 'returns a car' do
        data = JSON.parse(response.body)['data']['deleteCar']['car']

        expect(data).to include(
          'id' => be_present
        )
      end
    end

    context 'when car does not exist' do
      let(:query) do
        <<~GQL
          mutation {
            deleteCar(input: {
              id: "5d2d4e7c8f1b5c0b3b6e1b4f"
            }) {
              car {
                id
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
