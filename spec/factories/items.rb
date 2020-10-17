FactoryBot.define do
  factory :item do
    name (Faker::Coffee.blend_name)
    description (Faker::Coffee.notes )
    unit_price (Faker::Number.decimal(l_digits: 2))
    merchant_id (Faker::Number.number(digits: 10))

    after :create do |item|
      invoice = create(:invoice)
      create :invoice_items, item: item, invoice: invoice
    end
  end
end
