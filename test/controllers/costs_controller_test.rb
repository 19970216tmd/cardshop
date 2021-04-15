require 'test_helper'

class CostsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get costs_new_url
    assert_response :success
  end

  test "should get edit" do
    get costs_edit_url
    assert_response :success
  end

end
