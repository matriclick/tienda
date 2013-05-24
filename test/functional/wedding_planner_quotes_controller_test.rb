require 'test_helper'

class WeddingPlannerQuotesControllerTest < ActionController::TestCase
  setup do
    @wedding_planner_quote = wedding_planner_quotes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:wedding_planner_quotes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create wedding_planner_quote" do
    assert_difference('WeddingPlannerQuote.count') do
      post :create, wedding_planner_quote: @wedding_planner_quote.attributes
    end

    assert_redirected_to wedding_planner_quote_path(assigns(:wedding_planner_quote))
  end

  test "should show wedding_planner_quote" do
    get :show, id: @wedding_planner_quote.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @wedding_planner_quote.to_param
    assert_response :success
  end

  test "should update wedding_planner_quote" do
    put :update, id: @wedding_planner_quote.to_param, wedding_planner_quote: @wedding_planner_quote.attributes
    assert_redirected_to wedding_planner_quote_path(assigns(:wedding_planner_quote))
  end

  test "should destroy wedding_planner_quote" do
    assert_difference('WeddingPlannerQuote.count', -1) do
      delete :destroy, id: @wedding_planner_quote.to_param
    end

    assert_redirected_to wedding_planner_quotes_path
  end
end
