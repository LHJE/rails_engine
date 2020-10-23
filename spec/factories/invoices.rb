FactoryBot.define do
  factory :invoice do
    customer
    merchant_id { Faker::Number.within(range: 1..10) }
    status { "shipped" }
  end
end
