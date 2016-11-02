require 'test_helper'

class StatistiqueControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get index_bilan" do
    get :index_bilan
    assert_response :success
  end

  test "should get index_analyse" do
    get :index_analyse
    assert_response :success
  end

end
