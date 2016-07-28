require 'test_helper'

class UserTest < ActiveSupport::TestCase

	def setup
		@user = User.new(name: "Exampler user", email: "user@example.com")
	end

	test "Should be valid"  do
		assert @user.valid?
	end

	test "name should be present" do 
		@user.name = "   "
		assert_not @user.valid?
	end
end
