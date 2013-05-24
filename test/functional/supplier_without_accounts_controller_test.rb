require 'test_helper'

class SupplierWithoutAccountsControllerTest < ActionController::TestCase
  setup do
    @supplier_without_account = supplier_without_accounts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:supplier_without_accounts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create supplier_without_account" do
    assert_difference('SupplierWithoutAccount.count') do
      post :create, supplier_without_account: @supplier_without_account.attributes
    end

    assert_redirected_to supplier_without_account_path(assigns(:supplier_without_account))
  end

  test "should show supplier_without_account" do
    get :show, id: @supplier_without_account.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @supplier_without_account.to_param
    assert_response :success
  end

  test "should update supplier_without_account" do
    put :update, id: @supplier_without_account.to_param, supplier_without_account: @supplier_without_account.attributes
    assert_redirected_to supplier_without_account_path(assigns(:supplier_without_account))
  end

  test "should destroy supplier_without_account" do
    assert_difference('SupplierWithoutAccount.count', -1) do
      delete :destroy, id: @supplier_without_account.to_param
    end

    assert_redirected_to supplier_without_accounts_path
  end
end
