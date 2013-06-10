require 'test_helper'

class RefundRequestsControllerTest < ActionController::TestCase
  setup do
    @refund_request = refund_requests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:refund_requests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create refund_request" do
    assert_difference('RefundRequest.count') do
      post :create, refund_request: @refund_request.attributes
    end

    assert_redirected_to refund_request_path(assigns(:refund_request))
  end

  test "should show refund_request" do
    get :show, id: @refund_request.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @refund_request.to_param
    assert_response :success
  end

  test "should update refund_request" do
    put :update, id: @refund_request.to_param, refund_request: @refund_request.attributes
    assert_redirected_to refund_request_path(assigns(:refund_request))
  end

  test "should destroy refund_request" do
    assert_difference('RefundRequest.count', -1) do
      delete :destroy, id: @refund_request.to_param
    end

    assert_redirected_to refund_requests_path
  end
end
