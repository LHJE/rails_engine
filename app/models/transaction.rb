class Transaction < ApplicationRecord
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates :invoice_id,
            :credit_card_number,
            :result, presence: true
end
