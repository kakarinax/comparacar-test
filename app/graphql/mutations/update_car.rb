module Mutations
  class UpdateCar < Mutations::BaseMutation
    argument :id, ID, required: true
    argument :color, String, required: false
    argument :kms, Integer, required: false
    argument :version, Types::InputTypes::VersionInputType, required: false

    field :car, Types::ModelTypes::CarType, null: false
    field :errors, [String], null: false

    def resolve(id:, color: nil, kms: nil, version: nil)
      car = Car.find(BSON::ObjectId.from_string(id))

      raise GraphQL::ExecutionError, 'Car does not exist' if car.nil?

      car.color = color if color
      car.kms = kms if kms
      car.version = Version.new(version.to_h) if version

      if car.save
        { car:, errors: [] }
      else
        { car: nil, errors: car.errors.full_messages }
      end
    end
  end
end
