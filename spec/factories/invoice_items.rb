FactoryBot.define do
  factory :invoice_item do
    item
    invoice
    quantity { 12 }
    unit_price { 12345 }
  end
end
