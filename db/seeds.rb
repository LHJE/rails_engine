Customer.delete_all
Customer.reset_pk_sequence
Merchant.delete_all
Merchant.reset_pk_sequence
Item.delete_all
Item.reset_pk_sequence
Invoice.delete_all
Invoice.reset_pk_sequence
InvoiceItem.delete_all
InvoiceItem.reset_pk_sequence
Transaction.delete_all
Transaction.reset_pk_sequence

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create(: name: 'Star Wars' },: name: 'Lord of t, Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
10.times do
  Customer.create!(
    first_name: Faker::Games::Myst.character,
    last_name: Faker::Games::Pokemon.name,
  )
end

10.times do
  Merchant.create!(
    name: Faker::IndustrySegments.sub_sector,
  )
end

10.times do
  Item.create!(
    name: Faker::Coffee.blend_name,
    description: Faker::Coffee.notes,
    unit_price: Faker::Number.decimal(l_digits: 2),
    merchant_id: Faker::Number.number(digits: 10),
  )
end

10.times do
  Invoice.create!(
    customer_id: Faker::IDNumber.brazilian_id,
    merchant_id: Faker::Number.number(digits: 10),
    status: Faker::Boolean.boolean,
  )
end

10.times do
  InvoiceItem.create!(
    item_id: Faker::Number.number(digits: 10),
    invoice_id: Faker::Number.number(digits: 10),
    quantity: Faker::Number.decimal_part(digits: 2),
    unit_price: Faker::Number.decimal(l_digits: 2),
  )
end

10.times do
  Transaction.create!(
    invoice_id: Faker::Crypto.md5,
    credit_card_number: Faker::Number.number(digits:16),
    credit_card_expiration_date: "",
    result: Faker::Boolean.boolean,
  )
end
