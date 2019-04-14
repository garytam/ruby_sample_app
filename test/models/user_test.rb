require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Jo Bo", email: "jobo@hahaha.com", password_digest: "abcdefghij")
  end


  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = ""
    assert_not @user.valid?
  end



  test "email should be present" do
    @user.email = nil
    assert_not @user.valid?
  end

  test "name length should be less than 20" do
    @user.name = "*" * 21
    assert_not @user.valid?
  end


  test "email length should be less than 100" do
    @user.email= "*" * 101
    assert_not @user.valid?
  end

  test "email should be valid format" do
    valid_addresses = %w[user@example.com USER@fofo.com A_bc-de@foo.bar.og ding+dong@bong.com]

    valid_addresses.each do | addr |
      @user.email = addr
      assert @user.valid?, "Address #{addr} should be valid"
    end
  end

  test "email should be rejected" do
    addresses = %w[user@example,com USER&fofo.com A_bc-de.ding.bong@foo.bar. ding/ndong@bong.com foo@bar_baz.com barbar@bar+baz.com ]

    addresses.each do | addr |
      @user.email = addr
      assert_not @user.valid? , "Address #{addr} should not be valid"
    end
  end


  test "email address must be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = duplicate_user.email.upcase
    @user.save

    assert_not duplicate_user.valid?

  end

  test "password length >= 6" do
    @user.password_digest = "a" * 5
    @user.password_confirmation = "a" * 5

    assert_not @user.valid?
  end

end
