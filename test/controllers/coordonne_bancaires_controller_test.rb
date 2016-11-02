require 'test_helper'

class CoordonneBancairesControllerTest < ActionController::TestCase
  setup do
    @coordonne_bancaire = coordonne_bancaires(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:coordonne_bancaires)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create coordonne_bancaire" do
    assert_difference('CoordonneBancaire.count') do
      post :create, coordonne_bancaire: { code: @coordonne_bancaire.code, is_active: @coordonne_bancaire.is_active, nom: @coordonne_bancaire.nom }
    end

    assert_redirected_to coordonne_bancaire_path(assigns(:coordonne_bancaire))
  end

  test "should show coordonne_bancaire" do
    get :show, id: @coordonne_bancaire
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @coordonne_bancaire
    assert_response :success
  end

  test "should update coordonne_bancaire" do
    patch :update, id: @coordonne_bancaire, coordonne_bancaire: { code: @coordonne_bancaire.code, is_active: @coordonne_bancaire.is_active, nom: @coordonne_bancaire.nom }
    assert_redirected_to coordonne_bancaire_path(assigns(:coordonne_bancaire))
  end

  test "should destroy coordonne_bancaire" do
    assert_difference('CoordonneBancaire.count', -1) do
      delete :destroy, id: @coordonne_bancaire
    end

    assert_redirected_to coordonne_bancaires_path
  end
end
