require 'test_helper'

class PlantControllerTest < ActionController::TestCase
  test "should get recieve_hash" do
    get :recieve_hash
    assert_response :success
  end

end
