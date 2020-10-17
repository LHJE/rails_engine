class Item < ApplicationRecord
  belongs_to :merchant

  has_many :invoices, through: :invoice_items

  validates :name,
           :description,
           :unit_price,
           :merchant_id, presence: true

  def self.load_items(file_path)
    items = []
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |data|
      items << Item.new(data.to_h)
    end
    items
  end
end
