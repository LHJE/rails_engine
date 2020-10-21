FactoryBot.define do
  factory :transaction do
    invoice_id { 1 }
    credit_card_number { "1234 5678 9012 3456" }
    credit_card_expiration_date { "" }
    result { "success" }
  end
end
