require 'test_helper'

class ReportsControllerTest < ActionController::TestCase
  test "should get salestool" do
    get :salestool
    assert_response :success
  end

end
