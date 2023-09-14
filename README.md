# Rails CRUD App with GraphQL

This simple CRUD (Create, Read, Update, Delete) application is built with Ruby on Rails, Mongoid (a MongoDB ODM), and GraphQL. It provides mutations for creating, updating, and deleting cars, as well as queries to retrieve all cars and specific car details.

## Getting started

Prerequisites
Before you begin, ensure you have the following installed on your system:

- Ruby (version 3.1.2)
- Rails (version 7.0.7)
- MongoDB
- Bundler

## Installing
Follow these steps to get the project up and running:

- Clone this repository: `git clone git@github.com:kakarinax/comparacar-test.git`
- `cd comparacar-test`
- run bundle install command: `bundle install`
- start MongoDB service. You can check how to download and start it [here](https://www.mongodb.com/docs/manual/tutorial/install-mongodb-on-os-x/#std-label-install-mdb-community-macos) 
- run database setup command: `rails db:setup`
- run the rails server: `rails s`
- optional: seed the database if you want to test manually with some pre-added data: `rails db:seed`

It should be running on http://localhost:3000/

## Running tests
- run: `RAILS_ENV=test rspec`
- for a specific file: `RAILS_ENV=test rspec <file_path`

## GraphQL interface

The project includes the GraphiQL interface to easily test GraphQL queries and mutations.

To access GraphiQL, open your web browser and go to http://localhost:3000/graphiql. Here, you can interactively test your GraphQL queries and mutations.

## Usage
### Mutations

`CreateCar Mutation`

```graphql
mutation createCar{
  createCar(input: {
    color: "<color>",
    kms: kms, # integer
    version: {
      name: "<version_name>",
      year: year, # integer
    }
  }) {
      car {
        color
        kms
       version {
        name
        year
      }
    }
  }
}
```

`UpdateCar Mutation`

You can update all of the car attributes or just one, or just the version.
In case you don't want to update some of the attributes, remove it.

```graphql
mutation updateCar{
  updateCar(input: {
    id: "car.id", # string
    color: "<color>", 
    kms: kms, # integer
    version: {
      name: "<version_name>",
      year: year, # integer
    }
  }) {
    car {
      color
      kms
      version {
        name
        year
      }
    }
  }
```

`DeleteCar Mutation`
```graphql
mutation deleteCar{
  deleteCar(input: {
    id: "car_id", # string
    }
  }) {
    car {
      color
      kms
      version {
        name
        year
      }
    }
  }
```

### Queries
`Get all cars`

```graphql
query {
  cars {
    id
    color
    kms
    version {
      name
      year
    }
  }
}
```

`Get car by ID`

Retrieve one specific car by its ID.
```graphql
query {
  car(id:"car_id") {
    id
    color
    kms
    version {
      name
      year
    }
  }
}
```

`Get cars by color`
```graphql
query {
  carsByColor(color: "red"){
    id
    color
    kms
    version {
      name
      year
    }
  }
}
```

`Get cars by kms`
```graphql
query {
  carsByKms(kms: 12000){
    id
    color
    kms
    version {
      name
      year
    }
  }
}
```
