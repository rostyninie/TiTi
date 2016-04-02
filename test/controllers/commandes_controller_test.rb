require 'test_helper'

class CommandesControllerTest < ActionController::TestCase
  setup do
    @commande = commandes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:commandes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create commande" do
    assert_difference('Commande.count') do
      post :create, commande: { client_id: @commande.client_id, code: @commande.code, date_reglage: @commande.date_reglage, en_cour: @commande.en_cour, is_deleted: @commande.is_deleted, montant: @commande.montant }
    end

    assert_redirected_to commande_path(assigns(:commande))
  end

  test "should show commande" do
    get :show, id: @commande
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @commande
    assert_response :success
  end

  test "should update commande" do
    patch :update, id: @commande, commande: { client_id: @commande.client_id, code: @commande.code, date_reglage: @commande.date_reglage, en_cour: @commande.en_cour, is_deleted: @commande.is_deleted, montant: @commande.montant }
    assert_redirected_to commande_path(assigns(:commande))
  end

  test "should destroy commande" do
    assert_difference('Commande.count', -1) do
      delete :destroy, id: @commande
    end

    assert_redirected_to commandes_path
  end
end
