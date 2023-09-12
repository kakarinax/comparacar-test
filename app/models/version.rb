class Version
  include Mongoid::Document

  field :name, type: String
  field :year, type: Integer

  embedded_in :car
end
