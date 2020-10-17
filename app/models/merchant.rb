class Merchant < ApplicationRecord
  has_many :invoices

  validates :name, presence: true

  def self.load_merchants(file_path)
    merchants = []
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |data|
      merchants << Merchant.create!(name: data.to_h[:name])
    end
    merchants
  end
end
