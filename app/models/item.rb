require 'csv'

class Item < ApplicationRecord
  belongs_to :merchant, optional: true

  has_many :invoices, through: :invoice_items

  validates :name,
            :description,
            :unit_price,
            :merchant_id, presence: true

  def self.load_items(file_path)
    items = []
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |data|
      items << Item.create!(name: data.to_h[:name], description: data.to_h[:description], unit_price: (data.to_h[:unit_price].to_f / 100), merchant_id: data.to_h[:merchant_id])
    end
    items
  end
end
