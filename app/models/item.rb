class Item < ApplicationRecord
  validate :name,
           :description,
           :unit_price,
           :merchant_id
end
