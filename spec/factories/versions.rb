FactoryBot.define do
  factory :version do
    name { Faker::Vehicle.model }
    year { Faker::Vehicle.year }
    car
  end
end
