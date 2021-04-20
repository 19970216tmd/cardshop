class Product < ApplicationRecord
  has_many :orders, inverse_of: :product, dependent: :destroy, primary_key: :card_id, foreign_key: :card_id
end
