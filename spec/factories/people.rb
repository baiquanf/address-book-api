FactoryBot.define do
  factory :person do
    first_name { Faker::Name.first_name[1..50] }
    last_name { Faker::Name.last_name[1..50] }
    birthday { Faker::Date.birthday }

    factory :person_with_addresses do
      transient do
        addresses_count { 3 }
      end

      after(:create) do |person, evaluator|
        create_list(:address, evaluator.addresses_count, person: person)
      end
    end
  end
end
