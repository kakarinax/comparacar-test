module Types
  class QueryType < Types::BaseObject
    field :node, Types::NodeType, null: true, description: 'Fetches an object given its ID.' do
      argument :id, ID, required: true, description: 'ID of the object.'
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [Types::NodeType, { null: true }], null: true,
                                                     description: 'Fetches a list of objects given a list of IDs.' do
      argument :ids, [ID], required: true, description: 'IDs of the objects.'
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :cars, [Types::ModelTypes::CarType], null: false

    def cars
      Car.all
    end

    field :car, Types::ModelTypes::CarType, null: false do
      argument :id, ID, required: true
    end

    def car(id:)
      Car.find(BSON::ObjectId.from_string(id))
    end

    field :cars_by_color, [Types::ModelTypes::CarType], null: false do
      argument :color, String, required: true
    end

    def cars_by_color(color:)
      Car.where(color:)
    end

    field :cars_by_kms, [Types::ModelTypes::CarType], null: false do
      argument :kms, Integer, required: true
    end

    def cars_by_kms(kms:)
      Car.where(kms:)
    end
  end
end
