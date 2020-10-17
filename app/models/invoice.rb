class Invoice < ApplicationRecord
  validate :customer_id,
           :merchant_id,
           :status
end
