require 'test_helper'

class ClothMeasuresControllerTest < ActionController::TestCase
  setup do
    @cloth_measure = cloth_measures(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cloth_measures)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cloth_measure" do
    assert_difference('ClothMeasure.count') do
      post :create, cloth_measure: @cloth_measure.attributes
    end

    assert_redirected_to cloth_measure_path(assigns(:cloth_measure))
  end

  test "should show cloth_measure" do
    get :show, id: @cloth_measure.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cloth_measure.to_param
    assert_response :success
  end

  test "should update cloth_measure" do
    put :update, id: @cloth_measure.to_param, cloth_measure: @cloth_measure.attributes
    assert_redirected_to cloth_measure_path(assigns(:cloth_measure))
  end

  test "should destroy cloth_measure" do
    assert_difference('ClothMeasure.count', -1) do
      delete :destroy, id: @cloth_measure.to_param
    end

    assert_redirected_to cloth_measures_path
  end
end
