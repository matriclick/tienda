require 'test_helper'

class RocksControllerTest < ActionController::TestCase
  setup do
    @rock = rocks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rocks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rock" do
    assert_difference('Rock.count') do
      post :create, rock: @rock.attributes
    end

    assert_redirected_to rock_path(assigns(:rock))
  end

  test "should show rock" do
    get :show, id: @rock.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rock.to_param
    assert_response :success
  end

  test "should update rock" do
    put :update, id: @rock.to_param, rock: @rock.attributes
    assert_redirected_to rock_path(assigns(:rock))
  end

  test "should destroy rock" do
    assert_difference('Rock.count', -1) do
      delete :destroy, id: @rock.to_param
    end

    assert_redirected_to rocks_path
  end
end
