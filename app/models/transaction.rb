class Transaction < ApplicationRecord
  validate :invoice_id,
           :credit_card_number,
           :credit_card_expiration_date,
           :result
end
