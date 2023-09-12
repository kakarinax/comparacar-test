class Car
  include Mongoid::Document

  field :color, type: String
  field :km, type: Integer

  embeds_one :version
end
