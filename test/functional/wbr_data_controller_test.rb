require 'test_helper'

class WbrDataControllerTest < ActionController::TestCase
  setup do
    @wbr_datum = wbr_data(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:wbr_data)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create wbr_datum" do
    assert_difference('WbrDatum.count') do
      post :create, wbr_datum: @wbr_datum.attributes
    end

    assert_redirected_to wbr_datum_path(assigns(:wbr_datum))
  end

  test "should show wbr_datum" do
    get :show, id: @wbr_datum.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @wbr_datum.to_param
    assert_response :success
  end

  test "should update wbr_datum" do
    put :update, id: @wbr_datum.to_param, wbr_datum: @wbr_datum.attributes
    assert_redirected_to wbr_datum_path(assigns(:wbr_datum))
  end

  test "should destroy wbr_datum" do
    assert_difference('WbrDatum.count', -1) do
      delete :destroy, id: @wbr_datum.to_param
    end

    assert_redirected_to wbr_data_path
  end
end
