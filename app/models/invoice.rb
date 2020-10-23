require 'csv'

class Invoice < ApplicationRecord
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions

  belongs_to :customer, optional: true
  belongs_to :merchant, optional: true

  validates :customer_id,
            :merchant_id,
            :status, presence: true

  def self.load_invoices(file_path)
    invoices = []
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |data|
      invoices << Invoice.create!(customer_id: data.to_h[:customer_id], merchant_id: data.to_h[:merchant_id], status: data.to_h[:status])
    end
    invoices
  end
end
