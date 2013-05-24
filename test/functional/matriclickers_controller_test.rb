require 'test_helper'

class MatriclickersControllerTest < ActionController::TestCase
  setup do
    @matriclicker = matriclickers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:matriclickers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create matriclicker" do
    assert_difference('Matriclicker.count') do
      post :create, matriclicker: @matriclicker.attributes
    end

    assert_redirected_to matriclicker_path(assigns(:matriclicker))
  end

  test "should show matriclicker" do
    get :show, id: @matriclicker.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @matriclicker.to_param
    assert_response :success
  end

  test "should update matriclicker" do
    put :update, id: @matriclicker.to_param, matriclicker: @matriclicker.attributes
    assert_redirected_to matriclicker_path(assigns(:matriclicker))
  end

  test "should destroy matriclicker" do
    assert_difference('Matriclicker.count', -1) do
      delete :destroy, id: @matriclicker.to_param
    end

    assert_redirected_to matriclickers_path
  end
end
