require 'test_helper'

class CategoriSalairesControllerTest < ActionController::TestCase
  setup do
    @categori_salaire = categori_salaires(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:categori_salaires)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create categori_salaire" do
    assert_difference('CategoriSalaire.count') do
      post :create, categori_salaire: { code: @categori_salaire.code, is_active: @categori_salaire.is_active, nom: @categori_salaire.nom }
    end

    assert_redirected_to categori_salaire_path(assigns(:categori_salaire))
  end

  test "should show categori_salaire" do
    get :show, id: @categori_salaire
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @categori_salaire
    assert_response :success
  end

  test "should update categori_salaire" do
    patch :update, id: @categori_salaire, categori_salaire: { code: @categori_salaire.code, is_active: @categori_salaire.is_active, nom: @categori_salaire.nom }
    assert_redirected_to categori_salaire_path(assigns(:categori_salaire))
  end

  test "should destroy categori_salaire" do
    assert_difference('CategoriSalaire.count', -1) do
      delete :destroy, id: @categori_salaire
    end

    assert_redirected_to categori_salaires_path
  end
end
