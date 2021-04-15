class Order < ApplicationRecord
    belongs_to :product,foreign_key: :card_id
end
