FactoryBot.define do
  factory :invoice do
    customer_id { Faker::IDNumber.brazilian_id }
    merchant_id { Faker::Number.number(digits: 10) }
    status { Faker::Boolean.boolean }
  end
end
