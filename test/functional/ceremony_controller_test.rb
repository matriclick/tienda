require 'test_helper'

class CeremonyControllerTest < ActionController::TestCase
  test "should get menu" do
    get :menu
    assert_response :success
  end

  test "should get places" do
    get :places
    assert_response :success
  end

  test "should get tips" do
    get :tips
    assert_response :success
  end

end
