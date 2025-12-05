require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get company" do
    get pages_company_url
    assert_response :success
  end

  test "should get contact" do
    get pages_contact_url
    assert_response :success
  end
end
