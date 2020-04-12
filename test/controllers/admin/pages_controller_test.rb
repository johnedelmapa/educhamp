require 'test_helper'

class Admin::PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get dashboard" do
    get admin_pages_dashboard_url
    assert_response :success
  end

end
