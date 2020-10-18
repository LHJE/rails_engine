class Customer < ApplicationRecord
  has_many :invoices, through: :invoice

  validates :first_name,
            :last_name, presence: true
end
