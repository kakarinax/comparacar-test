module Mutations
  class DeleteCar < Mutations::BaseMutation
    argument :id, ID, required: true

    field :car, Types::ModelTypes::CarType, null: false

    def resolve(id:)
      car = Car.find(BSON::ObjectId.from_string(id))

      raise GraphQL::ExecutionError, 'Car does not exist' if car.nil?

      car.destroy

      { car: }
    end
  end
end
