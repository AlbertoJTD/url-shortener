require "test_helper"

class UserTest < ActionDispatch::IntegrationTest
  test 'guess can log in or register' do
    get links_path
    assert_match 'Register', response.body
    assert_match 'Login', response.body
  end

  test 'user can be logged in' do
    user = users(:user_one)
    sign_in user

    get links_path
    assert_match 'Profile', response.body
    assert_match 'Logout', response.body
  end
end
