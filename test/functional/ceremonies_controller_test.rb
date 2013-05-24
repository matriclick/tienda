require 'test_helper'

class CeremoniesControllerTest < ActionController::TestCase
  setup do
    @ceremony = ceremonies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ceremonies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ceremony" do
    assert_difference('Ceremony.count') do
      post :create, ceremony: @ceremony.attributes
    end

    assert_redirected_to ceremony_path(assigns(:ceremony))
  end

  test "should show ceremony" do
    get :show, id: @ceremony.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ceremony.to_param
    assert_response :success
  end

  test "should update ceremony" do
    put :update, id: @ceremony.to_param, ceremony: @ceremony.attributes
    assert_redirected_to ceremony_path(assigns(:ceremony))
  end

  test "should destroy ceremony" do
    assert_difference('Ceremony.count', -1) do
      delete :destroy, id: @ceremony.to_param
    end

    assert_redirected_to ceremonies_path
  end
end
