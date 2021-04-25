class Profile < ApplicationRecord
  validates :postalcode, presence: true
  validates :city, presence: true
  validates :adress, presence: true
  validates :sei_kana, presence: true
  validates :sei_kanzi, presence: true
  validates :mei_kana, presence: true
  validates :mei_kanzi, presence: true
  validates :tel, presence: true
end
