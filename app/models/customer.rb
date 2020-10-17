class Customer < ApplicationRecord
  has_many :invoices

  validates :first_name,
           :last_name, presence: true


  def self.load_customers(file_path)
    customers = []
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |data|
      customers << Customer.create!(first_name: data.to_h[:first_name], last_name: data.to_h[:last_name])
    end
    customers
  end
end
