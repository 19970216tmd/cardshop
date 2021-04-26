class CreditsController < ApplicationController
  require 'payjp'

  def new
    credit = Credit.where(user_id: current_user.id)
    redirect_to action: 'show' if credit.exists?
  end

  # payjpとCardのデータベース作成を実施します。
  def pay
    Payjp.api_key = 'sk_test_52b774f65a7f38ddc26f5bc6'
    if params['payjpToken'].blank?
      redirect_to action: 'new'
    else
      customer = Payjp::Customer.create(card: params['payjpToken'])
      @credit = Credit.new(user_id: current_user.id, customer_id: customer.id, credit_id: customer.default_card)
      if @credit.save
        redirect_to action: 'show'
      else
        redirect_to action: 'pay'
      end
    end
  end

  # PayjpとCardデータベースを削除します
  def delete
    credit = Credit.where(user_id: current_user.id).first
    if credit.present?
      Payjp.api_key = 'sk_test_52b774f65a7f38ddc26f5bc6'
      customer = Payjp::Customer.retrieve(credit.customer_id)
      customer.delete
      credit.delete
    end
    redirect_to action: 'new'
  end

  # Cardのデータpayjpに送り情報を取り出します
  def show
    credit = Credit.where(user_id: current_user.id).first
    if credit.blank?
      redirect_to action: 'new'
    else
      Payjp.api_key = 'sk_test_52b774f65a7f38ddc26f5bc6'
      customer = Payjp::Customer.retrieve(credit.customer_id)
      @default_credit_information = customer.cards.retrieve(credit.credit_id)
    end
  end
end
