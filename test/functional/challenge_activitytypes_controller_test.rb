require 'test_helper'

class ChallengeActivitytypesControllerTest < ActionController::TestCase
  setup do
    @challenge_activitytype = challenge_activitytypes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:challenge_activitytypes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create challenge_activitytype" do
    assert_difference('ChallengeActivitytype.count') do
      post :create, challenge_activitytype: @challenge_activitytype.attributes
    end

    assert_redirected_to challenge_activitytype_path(assigns(:challenge_activitytype))
  end

  test "should show challenge_activitytype" do
    get :show, id: @challenge_activitytype.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @challenge_activitytype.to_param
    assert_response :success
  end

  test "should update challenge_activitytype" do
    put :update, id: @challenge_activitytype.to_param, challenge_activitytype: @challenge_activitytype.attributes
    assert_redirected_to challenge_activitytype_path(assigns(:challenge_activitytype))
  end

  test "should destroy challenge_activitytype" do
    assert_difference('ChallengeActivitytype.count', -1) do
      delete :destroy, id: @challenge_activitytype.to_param
    end

    assert_redirected_to challenge_activitytypes_path
  end
end
