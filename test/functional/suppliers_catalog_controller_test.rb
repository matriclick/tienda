require 'test_helper'

class SuppliersCatalogControllerTest < ActionController::TestCase
  test "should get supplier_description" do
    get :supplier_description
    assert_response :success
  end

  test "should get supplier_products" do
    get :supplier_products
    assert_response :success
  end

  test "should get supplier_services" do
    get :supplier_services
    assert_response :success
  end

end
