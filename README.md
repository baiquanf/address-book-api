# Address Book API

> Write a simple Ruby on Rails application, with REST JSON API and basic RSpec (CRUD) tests, for maintaining persons and their addresses.

> Models

> Person
> - id (int)
> - first_name (string 50 mandatory)
> - last_name (string 50 mandatory)
> - birthday (date)
> - timestamps

> AddressType (values Home, Work, Cottage, Other)
> - id (int)
> - name (string 50 mandatory)
> - timestamps

> Address
> - id (int)
> - person_id (int mandatory) => reference to persons.id
> - address_type_id (int mandatory) => reference to address_types.id 
> - address (string 50)
> - zip (string 20 mandatory)
> - city (string 50 mandatory)
> - timestamps

> REST JSON API
> - it should some kind of authentication (e.g. API Key or OAuth)
> - it should have version namespacing (e.g. /api/1 and /api/2)

## Development environment:
* Ruby version 2.5.8
* Rails version 5.2.4.3
* Database SQLite

## Design
Created the basic REST JSON API for the CRUD operations with associations among Address, Person and AddressType. The table address_types is populated with seeds of fixed ids.

Token based authentication with Devise for Rails JSON APIs is applied to the resources.

## Setup
- Clone this repository in your development folder
  ```console
  $ git clone https://github.com/baiquanf/address-book-api
  ```
  and
  ```console
  $ cd address-book-api
  ```
- Install gems
  ```console
  $ bundle install
  ```
- Setup database
  ```console
  $ rails db:setup
  ```
  or
  ```console
  $ rails db:reset
  $ rails db:migrate
  $ rails db:seed
  ```
- Run the test
  ```console
  $ rspec --format documentation
  ```
- Start the server
  ```console
  $ rails server
  ```
## Usage
- Create an user 
  ```console
  $ curl --location --request POST 'http://localhost:3000/api/v1/users' \
  --header 'Content-Type: application/json' \
  --data-raw '{
    "data": {
      "attributes": {
        "email": "your_email@example.com",
        "password": "password",
              "password_confirmation": "password"
      }
    }
  }'
  ```
  Response
  ``` 
  {
    "id": 13,
    "email": "his_email@example.com",
    "created_at": "2020-06-09T19:16:37.041Z",
    "updated_at": "2020-06-09T19:16:37.041Z",
    "auth_token": "qPcp4uaZ7_CpedtsTVbV"
  }
  ``` 
  remember the auth_token, e.g., ```"auth_token":"qPcp4uaZ7_CpedtsTVbV"```.
  
  **NOTE:** each user has its unique auth_token.
- Sign in 
  ```console
  $ curl --globoff --location --request GET 'http://localhost:3000/users/sign_in' \
    --header 'auth_token: qPcp4uaZ7_CpedtsTVbV' 
  ```
- Create a person
  ```console
  $ curl --location --request POST 'http://localhost:3000/api/v1/people' \
    --header 'Authorization: qPcp4uaZ7_CpedtsTVbV' \
    --header 'Content-Type: application/json' \
    --data-raw '{
      "data": {
        "attributes": {
          "first_name": "FirstName",
          "last_name": "LastName",
                "birthday": "2000-01-01"
        }
      }
    }'
  ```
- Show people
  ```console
  $ curl --globoff --location --request GET 'http://localhost:3000/api/v1/people'  \
    --header 'Authorization: qPcp4uaZ7_CpedtsTVbV'
  ```
- Create an address
  ```console  
  $ curl --location --request POST 'http://localhost:3000/api/v1/addresses' \
    --header 'Authorization: qPcp4uaZ7_CpedtsTVbV' \
    --header 'Content-Type: application/json' \
    --data-raw '{
      "data": {
        "attributes": {
          "person_id": 2,
          "address_type_id": 2,
                "street": "my street",
                "zip": "00001",
                "city": "Helsinki"
        }
      }
    }'
  ```
- List addresses
  ```console
  $ curl --globoff --location --request GET 'http://localhost:3000/api/v1/addresses'  \
    --header 'Authorization: qPcp4uaZ7_CpedtsTVbV'
  ```
- Show an address
  ```console
  $ curl --globoff --location --request GET 'http://localhost:3000/api/v1/addresses/1'  \
    --header 'Authorization: qPcp4uaZ7_CpedtsTVbV'
  ```