module Types
  module InputTypes
    class VersionInputType < Types::BaseInputObject
      argument :id, ID, required: false
      argument :name, String, required: false
      argument :year, Integer, required: false
    end
  end
end
