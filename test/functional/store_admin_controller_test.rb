require 'test_helper'

class StoreAdminControllerTest < ActionController::TestCase
  test "should get select_store" do
    get :select_store
    assert_response :success
  end

  test "should get products" do
    get :products
    assert_response :success
  end

  test "should get purchases" do
    get :purchases
    assert_response :success
  end

  test "should get payments" do
    get :payments
    assert_response :success
  end

end
