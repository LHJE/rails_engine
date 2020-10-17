class Customer < ApplicationRecord
  validate :first_name,
           :last_name
end
