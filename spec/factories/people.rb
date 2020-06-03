FactoryBot.define do
  factory :person do
    first_name { Faker::Name.first_name[1..50] }
    last_name { Faker::Name.last_name[1..50] }
    birthday { Faker::Date.birthday }
  end
end
