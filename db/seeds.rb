20.times do
  Car.create!(
    color: Faker::Color.color_name,
    kms: Faker::Number.number(digits: 5),
    version: Version.new(
      name: Faker::Vehicle.model,
      year: Faker::Vehicle.year
    )
  )
end
