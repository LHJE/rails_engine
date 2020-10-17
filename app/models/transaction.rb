class Transaction < ApplicationRecord
  has_many :invoices

  validates :invoice_id,
           :credit_card_number,
           :credit_card_expiration_date,
           :result, presence: true
end
