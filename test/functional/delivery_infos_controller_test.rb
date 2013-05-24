require 'test_helper'

class DeliveryInfosControllerTest < ActionController::TestCase
  setup do
    @delivery_info = delivery_infos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:delivery_infos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create delivery_info" do
    assert_difference('DeliveryInfo.count') do
      post :create, delivery_info: @delivery_info.attributes
    end

    assert_redirected_to delivery_info_path(assigns(:delivery_info))
  end

  test "should show delivery_info" do
    get :show, id: @delivery_info.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @delivery_info.to_param
    assert_response :success
  end

  test "should update delivery_info" do
    put :update, id: @delivery_info.to_param, delivery_info: @delivery_info.attributes
    assert_redirected_to delivery_info_path(assigns(:delivery_info))
  end

  test "should destroy delivery_info" do
    assert_difference('DeliveryInfo.count', -1) do
      delete :destroy, id: @delivery_info.to_param
    end

    assert_redirected_to delivery_infos_path
  end
end
