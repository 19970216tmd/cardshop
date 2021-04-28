class Order < ApplicationRecord
  belongs_to :product, inverse_of: :orders, foreign_key: :card_id

  validates :price, presence: true, numericality: { only_integer: true }

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

  def getcredit(current_user_id)
    credit = Credit.find_by(user_id: current_user_id)
    return if credit.blank?

    Payjp.api_key = 'sk_test_52b774f65a7f38ddc26f5bc6'
    customer = Payjp::Customer.retrieve(credit.customer_id)
    @default_credit_information = customer.cards.retrieve(credit.credit_id)
  end
end
