FactoryBot.define do
  factory :address do
    address { Faker::Address.street_address }
    zip { Faker::Address.zip }
    city { Faker::Address.city }
    association :person, factory: :person
    association :address_type, factory: :address_type
  end
end
