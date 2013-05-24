require 'test_helper'

class SliderImagesControllerTest < ActionController::TestCase
  setup do
    @slider_image = slider_images(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:slider_images)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create slider_image" do
    assert_difference('SliderImage.count') do
      post :create, slider_image: @slider_image.attributes
    end

    assert_redirected_to slider_image_path(assigns(:slider_image))
  end

  test "should show slider_image" do
    get :show, id: @slider_image.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @slider_image.to_param
    assert_response :success
  end

  test "should update slider_image" do
    put :update, id: @slider_image.to_param, slider_image: @slider_image.attributes
    assert_redirected_to slider_image_path(assigns(:slider_image))
  end

  test "should destroy slider_image" do
    assert_difference('SliderImage.count', -1) do
      delete :destroy, id: @slider_image.to_param
    end

    assert_redirected_to slider_images_path
  end
end
