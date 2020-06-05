# Address Book API

Write a simple Ruby on Rails application, with REST JSON API and basic RSpec (CRUD) tests, for maintaining persons and their addresses.

Models

Person
- id (int)
- first_name (string 50 mandatory)
- last_name (string 50 mandatory)
- birthday (date)
- timestamps

AddressType (values Home, Work, Cottage, Other)
- id (int)
- name (string 50 mandatory)
- timestamps

Address
- id (int)
- person_id (int mandatory) => reference to persons.id
- address_type_id (int mandatory) => reference to address_types.id 
- address (string 50)
- zip (string 20 mandatory)
- city (string 50 mandatory)
- timestamps

REST JSON API
- it should some kind of authentication (e.g. API Key or OAuth)
- it should have version namespacing (e.g. /api/1 and /api/2)

Development environment:

* Ruby version 2.5.8

* Rails version 5.2.4.3

* Database SQLite
