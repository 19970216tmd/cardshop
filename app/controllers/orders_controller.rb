class OrdersController < ApplicationController
  before_action :login?

  def buy
    @id = params[:card_id]
    @card = Product.find_by(card_id: @id)
    @neworder = Order.new
    order = Order.new
    @order_id = order.getorderid
    @orders = order.getorder(@id, '1', current_user.id)
    @myorder = Order.find_by(card_id: @id, buysell_flug: '1', user_id: current_user.id)
    @price = order.getprice(@id, '3', current_user.id)
    @order = Order.order(order_id: 'desc').find_by(card_id: @id, buysell_flug: '3', price: @price)
    @default_credit_information = order.getcredit(current_user.id)
  end

  def buyer1
    order = Order.new
    @bid = order.getbidask(current_user.id, '1')
    @buy = order.getbuysell(current_user.id, '2', '2', '4', '2')
    @end = order.getend(current_user.id, '2', '2', '4', '2')
  end

  def buyer2
    @order = Order.find_by(order_id: params[:order_id])

    @detail = Product.joins(:orders).select('products.*, orders.*').find_by(orders: { order_id: params[:order_id] })

    @cost = Cost.new
  end

  def sell
    @id = params[:card_id]
    @card = Product.find_by(card_id: @id)
    @neworder = Order.new
    order = Order.new
    @order_id = order.getorderid
    @orders = order.getorder(@id, '3', current_user.id)
    @myorder = Order.find_by(card_id: @id, buysell_flug: '3', user_id: current_user.id)
    @price = order.getprice(@id, '1', current_user.id)
    @order = Order.order(order_id: 'ASC').find_by(card_id: @id, buysell_flug: '1', price: @price)
  end

  def seller1
    order = Order.new
    @ask = order.getbidask(current_user.id, '3')
    @sell = order.getbuysell(current_user.id, '4', '2', '2', '2')
    @end = order.getend(current_user.id, '4', '2', '2', '2')
  end

  def seller2
    @order = Order.find_by(order_id: params[:order_id])
    @detail = Product.joins(:orders).select('products.*, orders.*').find_by(orders: { order_id: params[:order_id] })

    case @order.buysell_flug
    when '2'
      @profile = Profile.find_by(user_id: @order.out_user_id)
    when '4'
      @profile = Profile.find_by(user_id: @order.user_id)
    end
  end

  def finish; end

  def create
    @neworder = Order.new(orderparams)
    @profile = Profile.find_by(user_id: current_user.id)

    if @neworder.buysell_flug == '1'
      credit = Credit.where(user_id: current_user.id).first
      Payjp.api_key = 'sk_test_52b774f65a7f38ddc26f5bc6'
      Payjp::Charge.create(amount: @neworder.price, customer: credit.customer_id, currency: 'jpy')
    end

    if @profile.blank?
      redirect_to profiles_new_path
    elsif @neworder.save
      redirect_to products_sell_path(order_id: @neworder.order_id)
    end
  end

  def update
    # render plain: params.inspect
    @order = Order.find_by(id: params[:id])
    @profile = Profile.find_by(user_id: current_user.id)

    if @order.buysell_flug == '2'
      credit = Credit.where(user_id: current_user.id).first
      Payjp.api_key = 'sk_test_52b774f65a7f38ddc26f5bc6'
      Payjp::Charge.create(amount: @order.price, customer: credit.customer_id, currency: 'jpy')
    end

    if @profile.blank?
      redirect_to profiles_new_path
    elsif @order.update(orderparams)
      case @order.out_flug
      when '0'
        redirect_to products_sell_path(order_id: @order.order_id)
      when '2'
        @cost = Cost.create(costparams[:cost])
        redirect_to request.referer
      else
        redirect_to request.referer
      end
    end
  end

  private

  def orderparams
    params.require(:order).permit(:order_id, :card_id, :user_id, :buysell_flug, :price, :orderdate, :out_flug,
                                  :out_user_id)
  end

  def costparams
    params.require(:order).permit(cost: %i[user_id order_id price out_flug])
  end
end
