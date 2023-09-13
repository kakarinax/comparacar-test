module Types
  class CarType < Types::BaseObject
    field :id, ID, null: false
    field :color, String, null: true
    field :kms, Integer, null: true

    field :version, Types::VersionType, null: false
  end
end
