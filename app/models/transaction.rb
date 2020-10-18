class Transaction < ApplicationRecord
  has_many :invoices, through: :invoice

  # validates :invoice_id,
  #          :credit_card_number,
  #          :credit_card_expiration_date,
  #          :result, presence: true

  validates :invoice_id,
            :credit_card_number,
            :result, presence: true
end
