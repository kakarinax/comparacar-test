module Types
  module ModelTypes
    class VersionType < Types::BaseObject
      field :id, ID, null: false
      field :name, String, null: true
      field :year, Integer, null: true
    end
  end
end
