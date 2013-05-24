require 'test_helper'

class PlaceImagesControllerTest < ActionController::TestCase
  setup do
    @place_image = place_images(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:place_images)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create place_image" do
    assert_difference('PlaceImage.count') do
      post :create, place_image: @place_image.attributes
    end

    assert_redirected_to place_image_path(assigns(:place_image))
  end

  test "should show place_image" do
    get :show, id: @place_image.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @place_image.to_param
    assert_response :success
  end

  test "should update place_image" do
    put :update, id: @place_image.to_param, place_image: @place_image.attributes
    assert_redirected_to place_image_path(assigns(:place_image))
  end

  test "should destroy place_image" do
    assert_difference('PlaceImage.count', -1) do
      delete :destroy, id: @place_image.to_param
    end

    assert_redirected_to place_images_path
  end
end
