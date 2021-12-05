require "test_helper"

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should create user if correct params were sent" do
    post '/api/v1/users', params: { email: "test@test.test", password: "Password123" }
    assert_response :created, { id: 1, email: "test@test.test" }
  end
end
