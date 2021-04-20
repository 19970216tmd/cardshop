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
    buysell_flug = Order.find_by(order_id: params[:order_id]).buysell_flug
    case buysell_flug
    when '1'
      @flug = '入札'
    when '2'
      @flug = '購入'
    when '3'
      @flug = '出品'
    when '4'
      @flug = '販売'
    when '99'
      @flug = '取り消し'
    end
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
