require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @user = users(:michael)
  end
  
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
    assert_template 'home/index'
  end
  
  test "valid login infomation" do
      get login_path
      post login_path, params: { email: @user.email,
                                     password: "password"  }
    assert is_logged_in?
    assert_redirected_to '/index'
    follow_redirect!
    assert_template 'home/index'
    assert_select 'a[href=?]', login_path, count:0
    assert_select 'a[href=?]', logout_path, count:1
  end
  
  test "login with valid infomation followed by logout" do
      get login_path
      post login_path, params: { email: @user.email,
                                     password: "password"  }
    assert is_logged_in?
    assert_redirected_to '/index'
    follow_redirect!
    assert_template 'home/index'
    assert_select 'a[href=?]', login_path, count:0
    assert_select 'a[href=?]', logout_path, count:1
    
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to '/'
    follow_redirect!
    assert_template 'home/top'
    assert_select 'a[href=?]', login_path, count:1
    assert_select 'a[href=?]', logout_path, count:0
  end
  
end
