require 'test_helper'

class CampaignUserAccountInfosControllerTest < ActionController::TestCase
  setup do
    @campaign_user_account_info = campaign_user_account_infos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:campaign_user_account_infos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create campaign_user_account_info" do
    assert_difference('CampaignUserAccountInfo.count') do
      post :create, campaign_user_account_info: @campaign_user_account_info.attributes
    end

    assert_redirected_to campaign_user_account_info_path(assigns(:campaign_user_account_info))
  end

  test "should show campaign_user_account_info" do
    get :show, id: @campaign_user_account_info.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @campaign_user_account_info.to_param
    assert_response :success
  end

  test "should update campaign_user_account_info" do
    put :update, id: @campaign_user_account_info.to_param, campaign_user_account_info: @campaign_user_account_info.attributes
    assert_redirected_to campaign_user_account_info_path(assigns(:campaign_user_account_info))
  end

  test "should destroy campaign_user_account_info" do
    assert_difference('CampaignUserAccountInfo.count', -1) do
      delete :destroy, id: @campaign_user_account_info.to_param
    end

    assert_redirected_to campaign_user_account_infos_path
  end
end
