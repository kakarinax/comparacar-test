module Types
  class MutationType < Types::BaseObject
    field :create_car, mutation: Mutations::CreateCar
    field :delete_car, mutation: Mutations::DeleteCar
    field :update_car, mutation: Mutations::UpdateCar
  end
end
