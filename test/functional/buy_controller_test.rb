require 'test_helper'

class BuyControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get notify" do
    get :notify
    assert_response :success
  end

  test "should get success" do
    get :success
    assert_response :success
  end

  test "should get failure" do
    get :failure
    assert_response :success
  end

end
