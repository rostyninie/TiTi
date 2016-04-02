require 'test_helper'

class AchatsControllerTest < ActionController::TestCase
  setup do
    @achat = achats(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:achats)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create achat" do
    assert_difference('Achat.count') do
      post :create, achat: { code: @achat.code, date_achat: @achat.date_achat, fournisseur_id: @achat.fournisseur_id, is_deleted: @achat.is_deleted, marge_brut: @achat.marge_brut, prix_achat_unitaire: @achat.prix_achat_unitaire, prix_ht: @achat.prix_ht, produit_id: @achat.produit_id, quantite: @achat.quantite, user_id: @achat.user_id }
    end

    assert_redirected_to achat_path(assigns(:achat))
  end

  test "should show achat" do
    get :show, id: @achat
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @achat
    assert_response :success
  end

  test "should update achat" do
    patch :update, id: @achat, achat: { code: @achat.code, date_achat: @achat.date_achat, fournisseur_id: @achat.fournisseur_id, is_deleted: @achat.is_deleted, marge_brut: @achat.marge_brut, prix_achat_unitaire: @achat.prix_achat_unitaire, prix_ht: @achat.prix_ht, produit_id: @achat.produit_id, quantite: @achat.quantite, user_id: @achat.user_id }
    assert_redirected_to achat_path(assigns(:achat))
  end

  test "should destroy achat" do
    assert_difference('Achat.count', -1) do
      delete :destroy, id: @achat
    end

    assert_redirected_to achats_path
  end
end
