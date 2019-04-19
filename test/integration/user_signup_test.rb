require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup info" do
    get signup_path
    before_count = User.count
    post users_path, params: {user:{ name: "",
                                   email: "dingdong@ding.com",
                                   password: "foo",
                                   password_confirmation: "doo"}}
    post_count = User.count

    assert_template 'users/new'
    assert_equal before_count, post_count
  end

  test "invalid signup info2" do
    get signup_path

    assert_no_difference 'User.count' do
      post users_path, params: {user:{ name: "",
                                       email: "dingdong@ding.com",
                                       password: "foo",
                                       password_confirmation: "doo"}}
    end

    assert_template 'users/new'
    assert_select 'li', text: "Name can't be blank"
    assert_select 'div#error_header', "The Form contains 2 errors"
  end


  test "valid signup info" do
    get signup_path


    assert_difference 'User.count', 1 do
      post users_path, params: {user:{ name: "ding",
                                       email: "dingdong@ding.com",
                                       password: "foo",
                                       password_confirmation: "foo"}}
    end
    follow_redirect!
    assert_template 'users/show'
  end

end
