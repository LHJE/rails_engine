class Item < ApplicationRecord
  belongs_to :merchant

  has_many :invoices, through: :invoice_items

  validates :name,
           :description,
           :unit_price,
           :merchant_id, presence: true
end
