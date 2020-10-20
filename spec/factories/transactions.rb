FactoryBot.define do
  factory :transaction do
    invoice_id { 1 }
    credit_card_number { Faker::Number.number(digits:16) }
    credit_card_expiration_date { "" }
    result { Faker::Boolean.boolean }
  end
end
