require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get products_home_url
    assert_response :success
  end

  test "should get buy" do
    get products_buy_url
    assert_response :success
  end

  test "should get sell" do
    get products_sell_url
    assert_response :success
  end

  test "should get bid" do
    get products_bid_url
    assert_response :success
  end

  test "should get ask" do
    get products_ask_url
    assert_response :success
  end

end
