require 'test_helper'

class DroitsControllerTest < ActionController::TestCase
  setup do
    @droit = droits(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:droits)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create droit" do
    assert_difference('Droit.count') do
      post :create, droit: { code: @droit.code, description: @droit.description, name: @droit.name }
    end

    assert_redirected_to droit_path(assigns(:droit))
  end

  test "should show droit" do
    get :show, id: @droit
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @droit
    assert_response :success
  end

  test "should update droit" do
    patch :update, id: @droit, droit: { code: @droit.code, description: @droit.description, name: @droit.name }
    assert_redirected_to droit_path(assigns(:droit))
  end

  test "should destroy droit" do
    assert_difference('Droit.count', -1) do
      delete :destroy, id: @droit
    end

    assert_redirected_to droits_path
  end
end
