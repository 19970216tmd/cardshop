class Order < ApplicationRecord
  belongs_to :product, inverse_of: :orders, foreign_key: :card_id
end
