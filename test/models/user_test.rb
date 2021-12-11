require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    user_attributes = {
      email: 'example-user-123@example.com',
      password: 'password',
      password_confirmation: 'password'
    }
    @user = User.new(user_attributes)
  end

  test 'user should be valid' do
    assert @user.valid?
  end

  test 'email should not be nil' do
    @user.email = nil

    assert_not @user.valid?
  end

  test 'password should not be nil' do
    @user.password = nil

    assert_not @user.valid?
  end

  test 'password_confirmation should not be nil' do
    @user.password_confirmation = nil

    assert_not @user.valid?
  end

  test 'email should not be blank' do
    @user.email = ' '

    assert_not @user.valid?
  end

  test 'password should not be blank' do
    @user.password = ' '

    assert_not @user.valid?
  end

  test 'password_confirmation should not be blank' do
    @user.password_confirmation = ' '

    assert_not @user.valid?
  end

  test 'email should not be too long' do
    @user.email = 'test'*255 + '@example.com'

    assert_not @user.valid?
  end

  test 'password should has minimum length 6' do
    @user.password = @user.password_confirmation = '12345'
    assert_not @user.valid?

    @user.password = @user.password_confirmation = '123456'
    assert @user.valid?
  end

  test 'email address should has correct format' do
    invalid_emails = %w[not-an-email not,an,email not+an+email not@an@email not.an.email]

    invalid_emails.each do |invalid_email|
      @user.email = invalid_email
      assert_not @user.valid?
    end
  end

  test 'should normalize email before save' do
    email = 'TeSt@TeSt.TeSt'
    password = 'password'
    password_confirmation = 'password'
    attributes = {
      email: email,
      password: password,
      password_confirmation: password_confirmation
    }

    user = User.new(attributes)
    assert_equal 'TeSt@TeSt.TeSt', user.email

    _ = user.save
    assert_equal 'test@test.test', user.email
  end

  test 'email address should be unique' do
    email = 'user-test-email-1234567890@example.com'
    password = 'password'
    password_confirmation = 'password'
    attributes = {
      email: email,
      password: password,
      password_confirmation: password_confirmation
    }

    _ = User.create(attributes)
    user2 = User.new(attributes)

    assert_not user2.valid?
  end
end
