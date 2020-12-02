require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "deactivate" do
    user = users(:two)
    user.active = false
    assert_nothing_raised { user.save }
    user.save!
    assert_equal(user.active, false)
  end
end
