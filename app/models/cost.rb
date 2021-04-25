class Cost < ApplicationRecord
  validates :price, presence: true, numericality: { only_integer: true, less_than: 0 }
  validates :bank_name, presence: true
  validates :bank_type, presence: true
  validates :bank_number, presence: true
  validates :bank_user_name_sei, presence: true
  validates :bank_user_name_mei, presence: true
end
