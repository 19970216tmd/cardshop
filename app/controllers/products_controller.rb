class ProductsController < ApplicationController
helper_method :user_signed_in?
  def home
    @products = Product.all
  end

  def buy
    @day = Date.today.strftime("%Y-%m-%d")
  end

  def sell
    #render plain: params.inspect
    @order = Product.joins(:orders).select("products.*, orders.*").where(orders: {order_id: params[:order_id]})
    buysell_flug = Order.find_by(order_id: params[:order_id]).buysell_flug
    if buysell_flug == '1'
      @flug = '入札'
    elsif buysell_flug == '2'
      @flug = '購入'
    elsif buysell_flug == '3'
      @flug = '出品'
    elsif buysell_flug == '4'
      @flug = '販売'
    elsif buysell_flug == '99'
      @flug = '取り消し'
    end
  end

  def bid
  end

  def ask
    @id = params[:card_id]
    card = Product.find_by(card_id: @id)
    @name = card.card_name
    @photo = card.shuuroku
  end
  
  def create
     @newproducts = Product.new(listparams)
    if @newproducts.save
    else
    end
  end
  
  def update
  end
  
  private
  def listparams
    params.require(:product).permit(:card_id,:card_name)
  end
end
