require 'test_helper'

class DressStockChangeNotificationsControllerTest < ActionController::TestCase
  setup do
    @dress_stock_change_notification = dress_stock_change_notifications(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dress_stock_change_notifications)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dress_stock_change_notification" do
    assert_difference('DressStockChangeNotification.count') do
      post :create, dress_stock_change_notification: @dress_stock_change_notification.attributes
    end

    assert_redirected_to dress_stock_change_notification_path(assigns(:dress_stock_change_notification))
  end

  test "should show dress_stock_change_notification" do
    get :show, id: @dress_stock_change_notification.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dress_stock_change_notification.to_param
    assert_response :success
  end

  test "should update dress_stock_change_notification" do
    put :update, id: @dress_stock_change_notification.to_param, dress_stock_change_notification: @dress_stock_change_notification.attributes
    assert_redirected_to dress_stock_change_notification_path(assigns(:dress_stock_change_notification))
  end

  test "should destroy dress_stock_change_notification" do
    assert_difference('DressStockChangeNotification.count', -1) do
      delete :destroy, id: @dress_stock_change_notification.to_param
    end

    assert_redirected_to dress_stock_change_notifications_path
  end
end
