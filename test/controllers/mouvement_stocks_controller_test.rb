require 'test_helper'

class MouvementStocksControllerTest < ActionController::TestCase
  setup do
    @mouvement_stock = mouvement_stocks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mouvement_stocks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mouvement_stock" do
    assert_difference('MouvementStock.count') do
      post :create, mouvement_stock: { achat_id: @mouvement_stock.achat_id, date: @mouvement_stock.date, prix_u: @mouvement_stock.prix_u, produit_id: @mouvement_stock.produit_id, quantite: @mouvement_stock.quantite, type: @mouvement_stock.type }
    end

    assert_redirected_to mouvement_stock_path(assigns(:mouvement_stock))
  end

  test "should show mouvement_stock" do
    get :show, id: @mouvement_stock
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mouvement_stock
    assert_response :success
  end

  test "should update mouvement_stock" do
    patch :update, id: @mouvement_stock, mouvement_stock: { achat_id: @mouvement_stock.achat_id, date: @mouvement_stock.date, prix_u: @mouvement_stock.prix_u, produit_id: @mouvement_stock.produit_id, quantite: @mouvement_stock.quantite, type: @mouvement_stock.type }
    assert_redirected_to mouvement_stock_path(assigns(:mouvement_stock))
  end

  test "should destroy mouvement_stock" do
    assert_difference('MouvementStock.count', -1) do
      delete :destroy, id: @mouvement_stock
    end

    assert_redirected_to mouvement_stocks_path
  end
end
