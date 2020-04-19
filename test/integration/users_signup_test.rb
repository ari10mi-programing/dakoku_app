require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  test "invalid signup infomation" do
    assert_no_difference 'User.count' do
      get signup_path
      post users_path, params: { name:  "",
                                     email: "user@invalid",
                                     password:              "foo",
                                     password_confirmation: "bar"  }
    end
    assert_template 'users/new'
  end
  
  test "valid signup infomation" do
    assert_difference 'User.count', 1 do
      get signup_path
      post users_path, params: { name:  "Example User",
                                     email: "user@example.com",
                                     password:              "password",
                                     password_confirmation: "password"  }
    end
    follow_redirect!
    assert_template 'home/top'
  end
  
end
