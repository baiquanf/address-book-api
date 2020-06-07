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
- Sign up/in 
  ```console
  $ curl --globoff --location --request POST 'http://localhost:3000/users?user[email]=example@example.com&user[password]=password&user[password_confirmation]=password' 

  ``` 
  remember the auth_token, e.g., ```"auth_token":"qPcp4uaZ7_CpedtsTVbV"``` 
- Sign in 
  ```console
  $ curl --globoff --location --request GET 'http://localhost:3000/users/sign_in' --header 'auth_token: qPcp4uaZ7_CpedtsTVbV' 
  ```
- Create a person
  ```
  $ curl --globoff --location --request POST 'http://localhost:3000/api/v1/people?person[first_name]=John1&person[last_name]=Smith1&person[birthday]=2000-01-01' --header 'Authorization: qPcp4uaZ7_CpedtsTVbV'
  ```
- Show people
  ```console
  $ curl --globoff --location --request GET 'http://localhost:3000/api/v1/people'--header 'Authorization: qPcp4uaZ7_CpedtsTVbV'
  ```
- Create an address
  ```console  
  $ curl --globoff --location --request POST 'http://localhost:3000/api/v1/addresses?address[person_id]=2&address[address_type_id]=2&address[street]=Helsinginkatu&address[zip]=00001&address[city]=Helsinki' --header 'Authorization: qPcp4uaZ7_CpedtsTVbV'
  ```
- List addresses
  ```console
  $ curl --globoff --location --request GET 'http://localhost:3000/api/v1/addresses' --header 'Authorization: qPcp4uaZ7_CpedtsTVbV'
  ```
- Show an address
  ```console
  $ curl --globoff --location --request GET 'http://localhost:3000/api/v1/addresses/1' --header 'Authorization: qPcp4uaZ7_CpedtsTVbV'
  ```