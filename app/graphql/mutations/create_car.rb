module Mutations
  class CreateCar < Mutations::BaseMutation
    graphql_name 'createCar'
    argument :color, String, required: false
    argument :kms, Integer, required: false
    argument :version, Types::InputTypes::VersionInputType, required: true

    field :car, Types::ModelTypes::CarType, null: false
    field :errors, [String], null: false

    def resolve(color:, kms:, version:)
      car = Car.new(
        color:,
        kms:,
        version: version.to_h
      )
      version = Version.new(version.to_h)
      car.version = version

      if car.save
        { car:, errors: [] }
      else
        { car: nil, errors: car.errors.full_messages }
      end
    end
  end
end
