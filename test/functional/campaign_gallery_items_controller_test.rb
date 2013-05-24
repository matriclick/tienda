require 'test_helper'

class CampaignGalleryItemsControllerTest < ActionController::TestCase
  setup do
    @campaign_gallery_item = campaign_gallery_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:campaign_gallery_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create campaign_gallery_item" do
    assert_difference('CampaignGalleryItem.count') do
      post :create, campaign_gallery_item: @campaign_gallery_item.attributes
    end

    assert_redirected_to campaign_gallery_item_path(assigns(:campaign_gallery_item))
  end

  test "should show campaign_gallery_item" do
    get :show, id: @campaign_gallery_item.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @campaign_gallery_item.to_param
    assert_response :success
  end

  test "should update campaign_gallery_item" do
    put :update, id: @campaign_gallery_item.to_param, campaign_gallery_item: @campaign_gallery_item.attributes
    assert_redirected_to campaign_gallery_item_path(assigns(:campaign_gallery_item))
  end

  test "should destroy campaign_gallery_item" do
    assert_difference('CampaignGalleryItem.count', -1) do
      delete :destroy, id: @campaign_gallery_item.to_param
    end

    assert_redirected_to campaign_gallery_items_path
  end
end
