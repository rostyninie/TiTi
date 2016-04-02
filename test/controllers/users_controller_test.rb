require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { compte: @user.compte, date_naissance: @user.date_naissance, groupe_id: @user.groupe_id, is_active: @user.is_active, nom: @user.nom, passe: @user.passe, photo_content_type: @user.photo_content_type, photo_file_name: @user.photo_file_name, photo_file_size: @user.photo_file_size, prenom: @user.prenom, tel: @user.tel }
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    patch :update, id: @user, user: { compte: @user.compte, date_naissance: @user.date_naissance, groupe_id: @user.groupe_id, is_active: @user.is_active, nom: @user.nom, passe: @user.passe, photo_content_type: @user.photo_content_type, photo_file_name: @user.photo_file_name, photo_file_size: @user.photo_file_size, prenom: @user.prenom, tel: @user.tel }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end
