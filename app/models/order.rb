class Order < ApplicationRecord
  belongs_to :product, inverse_of: :orders, foreign_key: :card_id

  def getorderid
    order_id = Order.maximum('order_id')
    if order_id.blank?
      order_id = 1
    else
      order_id += 1
    end
    order_id
  end

  def getorder(card_id, buysell_flug, user_id)
    Order.where(card_id: card_id, buysell_flug: buysell_flug).where.not(user_id: user_id)
  end

  def getprice(card_id, buysell_flug, user_id)
    Order.where(card_id: card_id, buysell_flug: buysell_flug).where.not(user_id: user_id).minimum(:price)
  end

  def getbidask(user_id, buysell_flug)
    Product.joins(:orders).select('products.*, orders.*').where(orders: { user_id: user_id, buysell_flug: buysell_flug })
  end

  def getbuysell(user_id, flug1, flug2, flug3, flug4)
    Product.joins(:orders).select('products.*, orders.*').where(orders: { out_user_id: user_id,
                                                                          buysell_flug: flug1 }).where.not(orders: { out_flug: flug2 })\
           .or(Product.joins(:orders).select('products.*, orders.*').where(orders: { user_id: user_id,
                                                                                     buysell_flug: flug3 }).where.not(orders: { out_flug: flug4 }))
  end

  def getend(user_id, flug1, flug2, flug3, flug4)
    Product.joins(:orders).select('products.*, orders.*').where(orders: { out_user_id: user_id, buysell_flug: flug1, out_flug: flug2 })\
           .or(Product.joins(:orders).select('products.*, orders.*').where(orders: { user_id: user_id, buysell_flug: flug3, out_flug: flug4 }))
  end
end
