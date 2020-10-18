class InvoiceItem < ApplicationRecord
  belongs_to :item, optional: true
  belongs_to :invoice, optional: true

  validates :item_id,
            :invoice_id,
            :quantity,
            :unit_price, presence: true
end
