class Invoice < ApplicationRecord
  has_many :items, through: :invoice_items
  has_many :transactions

  belongs_to :customer
  belongs_to :merchant

  validates :customer_id,
           :merchant_id,
           :status, presence: true

  def self.load_invoices(file_path)
    invoices = []
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |data|
      invoices << Invoice.new(data.to_h)
    end
    invoices
  end
end
