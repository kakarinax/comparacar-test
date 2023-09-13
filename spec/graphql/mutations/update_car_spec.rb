require 'rails_helper'

RSpec.describe Mutations::UpdateCar, type: :request do
  describe '.resolve' do
    let(:request) { post '/graphql', params: { query: } }

    context 'when updates a car and version sucessfully' do
      let!(:car) { create(:car) }

      let(:query) do
        <<~GQL
          mutation {
            updateCar(input: {
              id: "#{car.id}",
              color: "red",
              kms: 1000,
              version: {
                name: "new model",
                year: 2019
              }
            }) {
              car {
                id
                color
                kms
                version {
                  name
                }
              }
            }
          }
        GQL
      end

      before do
        request
      end

      it 'updates car and version' do
        expect(car.reload).to have_attributes(
          color: 'red',
          kms: 1000
        )
        expect(car.version).to have_attributes(
          name: 'new model',
          year: 2019
        )
      end

      context 'when updates only car' do
        let(:query) do
          <<~GQL
            mutation {
              updateCar(input: {
                id: "#{car.id}",
                color: "red",
                kms: 1000
              }) {
                car {
                  id
                  color
                  kms
                  version {
                    name
                  }
                }
              }
            }
          GQL
        end

        it 'updates car' do
          old_version = car.version
          expect(car.reload).to have_attributes(
            color: 'red',
            kms: 1000
          )
          expect(car.version).to eq(old_version)
        end
      end

      context 'when updates only version' do
        let(:query) do
          <<~GQL
            mutation {
              updateCar(input: {
                id: "#{car.id}",
                version: {
                  name: "new model",
                  year: 2019
                }
              }) {
                car {
                  id
                  color
                  kms
                  version {
                    name
                  }
                }
              }
            }
          GQL
        end

        it 'updates version' do
          old_color = car.color
          old_kms = car.kms
          expect(car.reload).to have_attributes(
            color: old_color,
            kms: old_kms
          )
          expect(car.version).to have_attributes(
            name: 'new model',
            year: 2019
          )
        end
      end
    end

    context 'when does not update' do
      let(:query) do
        <<~GQL
          mutation {
            updateCar(input: {
              id: "5d2d4e7c8f1b5c0b3b6e1b4f",
              color: "red",
              kms: 1000
            }) {
              car {
                id
                color
                kms
                version {
                  name
                }
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
