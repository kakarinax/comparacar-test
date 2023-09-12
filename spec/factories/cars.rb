FactoryBot.define do
  factory :car do
    color { Faker::Color.color_name }
    km { Faker::Number.number(digits: 5) }

    after(:build) do |car|
      car.version = FactoryBot.build(:version, car:)
    end
  end
end
