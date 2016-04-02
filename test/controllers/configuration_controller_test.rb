require 'test_helper'

class ConfigurationControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

end
