class CostsController < ApplicationController
  def new
    @costs = Cost.new
    @rireki = Cost.where(out_flug: '0')
    @price = Cost.all.sum(:price)

    @order_id = Order.maximum('order_id') + 1
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

    @price = Cost.all.sum(:price)

    if @price >= @costs.price && @costs.price.positive?

      @costs.price = @costs.price * -1

      redirect_to request.referer if @costs.save(priceparams)
    else
      redirect_to request.referer
    end
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
