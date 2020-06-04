FactoryBot.define do
  factory :address_type do
    name { Faker::Types.rb_string }
  end

  factory :address_type_with_addresses do
    transient do
      address_types_count { 3 }
    end

    after(:create) do |address_type, evaluator|
      create_list(:address_type, evaluator.address_types_count, address_type: address_type)
    end
  end
end
