class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  validates :item_id,
           :invoice_id,
           :quantity,
           :unit_price, presence: true

  def self.load_invoice_items(file_path)
    invoice_items = []
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |data|
      invoice_items << InvoiceItem.create!(item_id: data.to_h[:item_id], invoice_id: data.to_h[:invoice_id], quantity: data.to_h[:quantity], unit_price: data.to_h[:unit_price])
    end
    invoice_items
  end
end
