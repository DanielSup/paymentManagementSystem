require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @user_for_deactivation = users(:two)

    login_as(@user, scope: :user)
  end

  test "should get index" do
    get users_index_url
    assert_response :success
  end

  test "should patch deactivate user" do
    assert_difference('User.where(active: false).count') do
      patch user_url(@user_for_deactivation)
    end

    assert_redirected_to users_url
  end

end
