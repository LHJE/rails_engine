class Transaction < ApplicationRecord
  has_many :invoices

  # validates :invoice_id,
  #          :credit_card_number,
  #          :credit_card_expiration_date,
  #          :result, presence: true

  validates :invoice_id,
           :credit_card_number,
           :result, presence: true

  def self.load_transactions(file_path)
    transactions = []
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |data|
      transactions << Transaction.new(data.to_h)
    end
    transactions
  end
end
