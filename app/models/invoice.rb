class Invoice < ApplicationRecord
  has_many :items, through: :invoice_items
  has_many :transactions

  belongs_to :customer
  belongs_to :merchant

  validates :customer_id,
           :merchant_id,
           :status, presence: true
end
