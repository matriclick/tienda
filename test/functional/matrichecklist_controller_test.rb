require 'test_helper'

class MatrichecklistControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get reminders" do
    get :reminders
    assert_response :success
  end

  test "should get activity" do
    get :activity
    assert_response :success
  end

  test "should get edit" do
    get :edit
    assert_response :success
  end

  test "should get add" do
    get :add
    assert_response :success
  end

end
