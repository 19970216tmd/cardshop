class Product < ApplicationRecord
    has_many :orders,primary_key: :card_id,foreign_key: :card_id
end
