require 'test_helper'

class LeadContactsControllerTest < ActionController::TestCase
  setup do
    @lead_contact = lead_contacts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lead_contacts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lead_contact" do
    assert_difference('LeadContact.count') do
      post :create, lead_contact: @lead_contact.attributes
    end

    assert_redirected_to lead_contact_path(assigns(:lead_contact))
  end

  test "should show lead_contact" do
    get :show, id: @lead_contact.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lead_contact.to_param
    assert_response :success
  end

  test "should update lead_contact" do
    put :update, id: @lead_contact.to_param, lead_contact: @lead_contact.attributes
    assert_redirected_to lead_contact_path(assigns(:lead_contact))
  end

  test "should destroy lead_contact" do
    assert_difference('LeadContact.count', -1) do
      delete :destroy, id: @lead_contact.to_param
    end

    assert_redirected_to lead_contacts_path
  end
end
