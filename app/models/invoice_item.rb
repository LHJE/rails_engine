class InvoiceItem < ApplicationRecord
  validate :item_id,
           :invoice_id,
           :quantity,
           :unit_price
end
