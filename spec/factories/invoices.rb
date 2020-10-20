FactoryBot.define do
  factory :invoice do
    customer
    merchant
    status { Faker::Boolean.boolean }
  end
end
