require 'test_helper'

class SpecialsControllerTest < ActionController::TestCase
  test "should get vina" do
    get :vina
    assert_response :success
  end

end
