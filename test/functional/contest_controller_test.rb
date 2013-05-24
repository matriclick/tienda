require 'test_helper'

class ContestControllerTest < ActionController::TestCase
  test "should get matridream" do
    get :matridream
    assert_response :success
  end

end
