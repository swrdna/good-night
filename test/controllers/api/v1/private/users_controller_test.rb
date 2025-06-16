require "test_helper"

module Api::V1::Private
  class UsersControllerTest < ActionDispatch::IntegrationTest
    setup do
      @user = users(:one)
      @auth_headers = {
        "HTTP_AUTHORIZATION" => ActionController::HttpAuthentication::Basic.encode_credentials(
          ENV.fetch("BASIC_AUTH_USERNAME"),
          ENV.fetch("BASIC_AUTH_PASSWORD")
        )
      }
    end

    test "should get index" do
      get api_v1_private_users_url, as: :json, headers: @auth_headers
      assert_response :success
    end

    test "should create user" do
      assert_difference("User.count") do
        post api_v1_private_users_url, params: { user: { name: @user.name } }, as: :json, headers: @auth_headers
      end

      assert_response :created
    end

    test "should show user" do
      get api_v1_private_user_url(@user), as: :json, headers: @auth_headers
      assert_response :success
    end

    test "should update user" do
      patch api_v1_private_user_url(@user), params: { user: { name: @user.name } }, as: :json, headers: @auth_headers
      assert_response :success
    end

    test "should destroy user" do
      assert_difference("User.count", -1) do
        delete api_v1_private_user_url(@user), as: :json, headers: @auth_headers
      end

      assert_response :no_content
    end
  end
end
