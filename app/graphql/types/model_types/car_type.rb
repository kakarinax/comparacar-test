module Types
  module ModelTypes
    class CarType < Types::BaseObject
      field :id, ID, null: false
      field :color, String, null: true
      field :kms, Integer, null: true

      field :version, Types::ModelTypes::VersionType, null: false
    end
  end
end
