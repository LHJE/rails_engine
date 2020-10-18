class Merchant < ApplicationRecord
  has_many :invoices, through: :invoice

  validates :name, presence: true
end
