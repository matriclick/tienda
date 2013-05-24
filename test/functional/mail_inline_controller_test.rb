require 'test_helper'

class MailInlineControllerTest < ActionController::TestCase
  test "should get i_want_it" do
    get :i_want_it
    assert_response :success
  end

end
