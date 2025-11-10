require "test_helper"

class ViewsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get views_show_url
    assert_response :success
  end
end
