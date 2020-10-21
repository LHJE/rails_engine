FactoryBot.define do
  factory :item do
    name { "Good Coffee" }
    description { "It's pretty good" }
    unit_price { "12345" }
    merchant
  end
end
