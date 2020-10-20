FactoryBot.define do
  factory :invoice_item do
    item
    invoice
    quantity { Faker::Number.decimal_part(digits: 2) }
    unit_price { Faker::Number.decimal(l_digits: 2) }
  end
end
