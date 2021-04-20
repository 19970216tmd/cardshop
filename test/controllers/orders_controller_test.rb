require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
  test 'should get buy' do
    get orders_buy_url
    assert_response :success
  end

  test 'should get sell' do
    get orders_sell_url
    assert_response :success
  end

  test 'should get buyer1' do
    get orders_buyer1_url
    assert_response :success
  end

  test 'should get buyer2' do
    get orders_buyer2_url
    assert_response :success
  end

  test 'should get seller1' do
    get orders_seller1_url
    assert_response :success
  end

  test 'should get seller2' do
    get orders_seller2_url
    assert_response :success
  end

  test 'should get finish' do
    get orders_finish_url
    assert_response :success
  end
end
