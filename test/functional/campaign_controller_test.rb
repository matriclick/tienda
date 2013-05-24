require 'test_helper'

class CampaignControllerTest < ActionController::TestCase
  test "should get anecdotes" do
    get :anecdotes
    assert_response :success
  end

  test "should get supplier_gallery" do
    get :supplier_gallery
    assert_response :success
  end

  test "should get bases" do
    get :bases
    assert_response :success
  end

  test "should get wedding_of_the_year" do
    get :wedding_of_the_year
    assert_response :success
  end

  test "should get how_to_win" do
    get :how_to_win
    assert_response :success
  end

  test "should get give_it_away" do
    get :give_it_away
    assert_response :success
  end

end
