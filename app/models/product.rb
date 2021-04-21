class Product < ApplicationRecord
  has_many :orders, inverse_of: :product, dependent: :destroy, primary_key: :card_id, foreign_key: :card_id

  def sell(buysell_flug)
    case buysell_flug
    when '1'
      flug = '入札'
    when '2'
      flug = '購入'
    when '3'
      flug = '出品'
    when '4'
      flug = '販売'
    when '99'
      flug = '取り消し'
    end
    flug
  end
end
