require 'test_helper'

class RayonsControllerTest < ActionController::TestCase
  setup do
    @rayon = rayons(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rayons)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rayon" do
    assert_difference('Rayon.count') do
      post :create, rayon: { code: @rayon.code, is_active: @rayon.is_active, nom: @rayon.nom }
    end

    assert_redirected_to rayon_path(assigns(:rayon))
  end

  test "should show rayon" do
    get :show, id: @rayon
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rayon
    assert_response :success
  end

  test "should update rayon" do
    patch :update, id: @rayon, rayon: { code: @rayon.code, is_active: @rayon.is_active, nom: @rayon.nom }
    assert_redirected_to rayon_path(assigns(:rayon))
  end

  test "should destroy rayon" do
    assert_difference('Rayon.count', -1) do
      delete :destroy, id: @rayon
    end

    assert_redirected_to rayons_path
  end
end
