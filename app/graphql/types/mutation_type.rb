module Types
  class MutationType < Types::BaseObject
    field :create_car, mutation: Mutations::CreateCar
  end
end
