class CostsController < ApplicationController
  before_action :login?

  def new
    @costs = Cost.new
    @rireki = Cost.where(out_flug: '0')
    @price = Cost.where(user_id: current_user.id).sum(:price)

    @order_id = Order.maximum('order_id') + 1
    a
  end

  def edit
    @edit = Cost.where(out_flug: '0')
    @finish = Cost.where(out_flug: '3')
  end

  def bank
    @bank = Cost.find(params[:id])
  end

  def create
    @costs = Cost.new(priceparams)

    @price = Cost.where(user_id: current_user.id).sum(:price)

    if @costs.price.present?
      request.referer if @costs.price > @price
      @costs.price = @costs.price * -1
    end

    redirect_to request.referer if @costs.save(priceparams)
  end

  def update
    @bank = Cost.find(params[:id])
    redirect_to costs_edit_path if @bank.update(priceparams)
  end

  private

  def priceparams
    params.require(:cost).permit(:user_id, :order_id, :price, :out_flug, :bank_name, :bank_type, :bank_number,
                                 :bank_user_name_sei, :bank_user_name_mei)
  end
end
