class Car
  include Mongoid::Document

  field :color, type: String
  field :kms, type: Integer

  embeds_one :version
end
