require 'test_helper'

class UserTest < ActiveSupport::TestCase

	def setup
		@user = User.new(name: "Exampler user", email: "user@example.com", password: "javier1", password_confirmation: "javier1")
	end

	test "Should be valid"  do
		assert @user.valid?
	end

	test "name should be present" do 
		@user.name = "   "
		assert_not @user.valid?
	end

	test "email should be present" do 
		@user.email = "   "
		assert_not @user.valid?
	end

	test "name should not be too long" do
		@user.name = "a" * 51
		assert_not @user.valid?
	end

	test "email shoul not be too long" do 
		@user.email = "a" * 244 + "@example.com"
		assert_not @user.valid?
	end

	test "email validation should accept valid addresses" do 
		valid_addresses = %w[user@example.com USER@foo.com A_US-ER@foo.bar.org first.last@foo.jp alice+javier@numero.cn]
		valid_addresses.each do |valid_address|
			@user.email = valid_address
			assert @user.valid?, "#{valid_address.inspect}, should be vaild"
		end
	end

	test "email validation should accept invalid addresses" do 
		invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
        invalid_addresses.each do |invalid_address|
            @user.email = invalid_address
            assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
		end
	end

	test "email address should be unique" do
		duplique_user = @user.dup
		duplique_user.email = @user.email.upcase
		@user.save
		assert_not duplique_user.valid?
	end

	test "password should be present (noblank)" do 
		@user.password = @user.password_confirmation = "  " * 6
		assert_not @user.valid?
	end

	test "password should  have a minimum length" do 
		@user.password = @user.password_confirmation = "a" * 5
		assert_not @user.valid?
	end

	test "authenticated? should return false for a user with nil digest" do
    	assert_not @user.authenticated?(:remember, '')
  	end


end
