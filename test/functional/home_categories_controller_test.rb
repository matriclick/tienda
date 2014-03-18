require 'test_helper'

class HomeCategoriesControllerTest < ActionController::TestCase
  setup do
    @home_category = home_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:home_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create home_category" do
    assert_difference('HomeCategory.count') do
      post :create, home_category: @home_category.attributes
    end

    assert_redirected_to home_category_path(assigns(:home_category))
  end

  test "should show home_category" do
    get :show, id: @home_category.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @home_category.to_param
    assert_response :success
  end

  test "should update home_category" do
    put :update, id: @home_category.to_param, home_category: @home_category.attributes
    assert_redirected_to home_category_path(assigns(:home_category))
  end

  test "should destroy home_category" do
    assert_difference('HomeCategory.count', -1) do
      delete :destroy, id: @home_category.to_param
    end

    assert_redirected_to home_categories_path
  end
end
