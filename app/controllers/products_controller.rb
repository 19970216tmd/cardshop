class ProductsController < ApplicationController
  helper_method :user_signed_in?
  def home
    @products = Product.all
  end

  def buy
    @day = Date.current.strftime('%Y-%m-%d')
  end

  def sell
    # render plain: params.inspect
    @order = Product.joins(:orders).select('products.*, orders.*').where(orders: { order_id: params[:order_id] })
    product = Product.new
    @flug = product.sell(Order.find_by(order_id: params[:order_id]).buysell_flug)
  end

  def bid; end

  def ask
    @id = params[:card_id]
    card = Product.find_by(card_id: @id)
    @name = card.card_name
    @photo = card.shuuroku
  end

  def create; end

  def update; end
end
