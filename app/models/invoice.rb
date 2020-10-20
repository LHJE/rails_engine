class Invoice < ApplicationRecord
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions, through: :invoice_items

  belongs_to :customer, optional: true
  belongs_to :merchant, optional: true

  validates :customer_id,
            :merchant_id,
            :status, presence: true
end
