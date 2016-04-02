require 'test_helper'

class CategorieDroitsControllerTest < ActionController::TestCase
  setup do
    @categorie_droit = categorie_droits(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:categorie_droits)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create categorie_droit" do
    assert_difference('CategorieDroit.count') do
      post :create, categorie_droit: { categorie_id: @categorie_droit.categorie_id, droit_id: @categorie_droit.droit_id }
    end

    assert_redirected_to categorie_droit_path(assigns(:categorie_droit))
  end

  test "should show categorie_droit" do
    get :show, id: @categorie_droit
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @categorie_droit
    assert_response :success
  end

  test "should update categorie_droit" do
    patch :update, id: @categorie_droit, categorie_droit: { categorie_id: @categorie_droit.categorie_id, droit_id: @categorie_droit.droit_id }
    assert_redirected_to categorie_droit_path(assigns(:categorie_droit))
  end

  test "should destroy categorie_droit" do
    assert_difference('CategorieDroit.count', -1) do
      delete :destroy, id: @categorie_droit
    end

    assert_redirected_to categorie_droits_path
  end
end
