module Types
  class MutationType < Types::BaseObject
    field :create_car, mutation: Mutations::CreateCar
    field :delete_car, mutation: Mutations::DeleteCar
  end
end
