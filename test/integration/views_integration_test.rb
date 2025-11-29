require "test_helper"

class ViewsIntegrationTest < ActionDispatch::IntegrationTest
  test 'creates a view when a link is visited' do
    link = links(:link_one)

    assert_difference 'View.count' do
      get view_path(link)

      assert_response :redirect
    end
  end

  test 'redirects to the link url' do
    link = links(:link_one)
    get view_path(link)

    assert_redirected_to link.url
  end
end
