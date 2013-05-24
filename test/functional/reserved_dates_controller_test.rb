require 'test_helper'

class ReservedDatesControllerTest < ActionController::TestCase
  setup do
    @reserved_date = reserved_dates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reserved_dates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create reserved_date" do
    assert_difference('ReservedDate.count') do
      post :create, reserved_date: @reserved_date.attributes
    end

    assert_redirected_to reserved_date_path(assigns(:reserved_date))
  end

  test "should show reserved_date" do
    get :show, id: @reserved_date.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @reserved_date.to_param
    assert_response :success
  end

  test "should update reserved_date" do
    put :update, id: @reserved_date.to_param, reserved_date: @reserved_date.attributes
    assert_redirected_to reserved_date_path(assigns(:reserved_date))
  end

  test "should destroy reserved_date" do
    assert_difference('ReservedDate.count', -1) do
      delete :destroy, id: @reserved_date.to_param
    end

    assert_redirected_to reserved_dates_path
  end
end
