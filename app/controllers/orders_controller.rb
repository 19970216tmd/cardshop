class OrdersController < ApplicationController
  before_action :login?
  
  def buy
    @id = params[:card_id]
    card = Product.find_by(card_id: @id)
    @name = card.card_name
    @photo = card.shuuroku
    
    @order_id = Order.maximum('order_id')
    if @order_id.blank?
      @order_id = 1
    else
      @order_id = @order_id + 1
    end
    
    @orders = Order.where(card_id: @id,buysell_flug: '1').where.not(user_id: current_user.id)
    @myorder = Order.find_by(card_id: @id,buysell_flug: '1',user_id: current_user.id)
    @buyprice = Order.find_by(card_id: @id,buysell_flug: '1',user_id: current_user.id)
    @neworder = Order.new
    
    @today = Date.today.strftime("%Y-%m-%d")
    @price = Order.where(card_id: @id,buysell_flug: '3').where.not(user_id: current_user.id).minimum(:price)
    @order = Order.order(order_id: 'desc').find_by(card_id: @id,buysell_flug: '3',price: @price)
  end
  
  def buyer1
    @bid = Product.joins(:orders).select("products.*, orders.*").where(orders: {user_id: current_user.id,buysell_flug: '1'})
    
    @buy = Product.joins(:orders).select("products.*, orders.*").where(orders: {out_user_id: current_user.id,buysell_flug: '2'}).where.not(orders: {out_flug: '2'})\
    .or(Product.joins(:orders).select("products.*, orders.*").where(orders: {user_id: current_user.id,buysell_flug: '4'}).where.not(orders: {out_flug: '2'}))
    
    @end = Product.joins(:orders).select("products.*, orders.*").where(orders: {out_user_id: current_user.id,buysell_flug: '2',out_flug: '2'})\
    .or(Product.joins(:orders).select("products.*, orders.*").where(orders: {user_id: current_user.id,buysell_flug: '4',out_flug: '2'}))
    
  end

  def buyer2
    @order = Order.find_by(order_id: params[:order_id])
    
    @detail = Product.joins(:orders).select("products.*, orders.*").find_by(orders: {order_id: params[:order_id]})
    
    @cost = Cost.new
  end

  def sell
    @id = params[:card_id]
    card = Product.find_by(card_id: @id)
    @name = card.card_name
    @photo = card.shuuroku
    
    @order_id = Order.maximum('order_id')
    if @order_id.blank?
      @order_id = 1
    else
      @order_id = @order_id + 1
    end
    
    @orders = Order.where(card_id: @id,buysell_flug: '3').where.not(user_id: current_user.id)
    @myorder = Order.find_by(card_id: @id,buysell_flug: '3',user_id: current_user.id)
    @sellprice = Order.find_by(card_id: @id,buysell_flug: '3',user_id: current_user.id)
    @neworder = Order.new
    
    @today = Date.today.strftime("%Y-%m-%d")
    @price = Order.where(card_id: @id,buysell_flug: '1').where.not(user_id: current_user.id).minimum(:price)
    @order = Order.order(order_id: 'ASC').find_by(card_id: @id,buysell_flug: '1',price: @price)
  end

  def seller1
    @ask = Product.joins(:orders).select("products.*, orders.*").where(orders: {user_id: current_user.id,buysell_flug: '3'})
    
    @sell = Product.joins(:orders).select("products.*, orders.*").where(orders: {out_user_id: current_user.id,buysell_flug: '4'}).where.not(orders: {out_flug: '2'})\
    .or(Product.joins(:orders).select("products.*, orders.*").where(orders: {user_id: current_user.id,buysell_flug: '2'}).where.not(orders: {out_flug: '2'}))
    
    @end = Product.joins(:orders).select("products.*, orders.*").where(orders: {out_user_id: current_user.id,buysell_flug: '4',out_flug: '2'})\
    .or(Product.joins(:orders).select("products.*, orders.*").where(orders: {user_id: current_user.id,buysell_flug: '2',out_flug: '2'}))
    
  end

  def seller2
    @order = Order.find_by(order_id: params[:order_id])
    
    @detail = Product.joins(:orders).select("products.*, orders.*").find_by(orders: {order_id: params[:order_id]})
    
    if @order.buysell_flug == '2'
      @profile = Profile.find_by(user_id: @order.out_user_id)
    elsif @order.buysell_flug == '4'
      @profile = Profile.find_by(user_id: @order.user_id)
    end
  end

  def finish
  end
  
  def create
     @neworder = Order.new(orderparams)
    if @neworder.save
      redirect_to products_sell_path(order_id: @neworder.order_id)
    else
    end
  end
  
  def update
    #render plain: params.inspect
    @order = Order.find(params[:id])
    if @order.update(orderparams)
      if @order.out_flug == '0'
        redirect_to products_sell_path(order_id: @order.order_id)
      elsif @order.out_flug == '2'
        @cost = Cost.create(costparams[:cost])
        redirect_to request.referer
      else
        redirect_to request.referer
      end
    else
    end
  end
  
  private
  def orderparams
    params.require(:order).permit(:order_id,:card_id,:user_id,:buysell_flug,:price,:orderdate,:out_flug,:out_user_id)
  end
  
  def costparams
    params.require(:order).permit(cost:[:user_id,:order_id,:price,:out_flug])
  end
end
