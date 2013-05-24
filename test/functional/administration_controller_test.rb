require 'test_helper'

class AdministrationControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show_supplier" do
    get :show_supplier
    assert_response :success
  end

  test "should get show_supplier_products" do
    get :show_supplier_products
    assert_response :success
  end

  test "should get show_supplier_services" do
    get :show_supplier_services
    assert_response :success
  end

end
