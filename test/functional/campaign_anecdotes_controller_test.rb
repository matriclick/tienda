require 'test_helper'

class CampaignAnecdotesControllerTest < ActionController::TestCase
  setup do
    @campaign_anecdote = campaign_anecdotes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:campaign_anecdotes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create campaign_anecdote" do
    assert_difference('CampaignAnecdote.count') do
      post :create, campaign_anecdote: @campaign_anecdote.attributes
    end

    assert_redirected_to campaign_anecdote_path(assigns(:campaign_anecdote))
  end

  test "should show campaign_anecdote" do
    get :show, id: @campaign_anecdote.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @campaign_anecdote.to_param
    assert_response :success
  end

  test "should update campaign_anecdote" do
    put :update, id: @campaign_anecdote.to_param, campaign_anecdote: @campaign_anecdote.attributes
    assert_redirected_to campaign_anecdote_path(assigns(:campaign_anecdote))
  end

  test "should destroy campaign_anecdote" do
    assert_difference('CampaignAnecdote.count', -1) do
      delete :destroy, id: @campaign_anecdote.to_param
    end

    assert_redirected_to campaign_anecdotes_path
  end
end
