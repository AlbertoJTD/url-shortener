require "test_helper"

class LinksIntegrationTest < ActionDispatch::IntegrationTest
  test 'links index' do
    get links_path
    assert_response :success
    assert_select 'h1', 'URL Shortener'
  end

  test 'create link requires url' do
    link_params = {
      link: {
        url: ''
      }
    }
    post links_path, params: link_params
    assert_response :unprocessable_entity
  end

  test 'create link as guest as html' do
    link_params = {
      link: {
        url: 'https://example.com'
      }
    }

    assert_difference 'Link.count' do
      post links_path, params: link_params
      assert_response :redirect
      assert_nil Link.last.user_id
    end
  end

  test 'create link as guest as turbo_stream' do
    link_params = {
      link: {
        url: 'https://example.com'
      }
    }

    assert_difference 'Link.count' do
      post links_path(format: :turbo_stream), params: link_params
      assert_response :ok
      assert_nil Link.last.user_id
    end
  end

  test 'create link as user' do
    user = users(:user_one)
    sign_in user

    link_params = {
      link: {
        url: 'https://google.com'
      }
    }

    assert_difference 'Link.count' do
      post links_path, params: link_params

      assert_response :redirect
      assert_equal user.id, Link.last.user_id
    end
  end

  test 'cannot edit link as guest' do
    link_one = links(:link_one)
    get edit_link_path(link_one)

    assert_response :redirect
  end

  test "cannot edit user's link as guest" do
    anonymous = links(:anonymous)
    get edit_link_path(anonymous)

    assert_response :redirect
  end

  test "can edit user's link as owner" do
    user = users(:user_one)
    sign_in user

    link_one = links(:link_one)
    get edit_link_path(link_one)

    assert_response :success
  end

  test "cannot edit another user's link" do
    user = users(:user_one)
    sign_in user

    link_two = links(:link_two)
    get edit_link_path(link_two)

    assert_response :redirect
    assert_equal 'You are not authorized to edit this link', flash[:alert]
  end
end
