require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get entrance" do
    get home_entrance_url
    assert_response :success
  end
end
