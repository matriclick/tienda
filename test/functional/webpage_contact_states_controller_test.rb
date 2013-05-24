require 'test_helper'

class WebpageContactStatesControllerTest < ActionController::TestCase
  setup do
    @webpage_contact_state = webpage_contact_states(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:webpage_contact_states)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create webpage_contact_state" do
    assert_difference('WebpageContactState.count') do
      post :create, webpage_contact_state: @webpage_contact_state.attributes
    end

    assert_redirected_to webpage_contact_state_path(assigns(:webpage_contact_state))
  end

  test "should show webpage_contact_state" do
    get :show, id: @webpage_contact_state.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @webpage_contact_state.to_param
    assert_response :success
  end

  test "should update webpage_contact_state" do
    put :update, id: @webpage_contact_state.to_param, webpage_contact_state: @webpage_contact_state.attributes
    assert_redirected_to webpage_contact_state_path(assigns(:webpage_contact_state))
  end

  test "should destroy webpage_contact_state" do
    assert_difference('WebpageContactState.count', -1) do
      delete :destroy, id: @webpage_contact_state.to_param
    end

    assert_redirected_to webpage_contact_states_path
  end
end
