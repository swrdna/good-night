# frozen_string_literal: true

require "test_helper"

module Api::V1::Private
  class UserFollowControllerTest < ActionDispatch::IntegrationTest
    setup do
      @user = users(:one)
      @target_user = users(:two)
      @auth_headers = {
        "HTTP_AUTHORIZATION" => ActionController::HttpAuthentication::Basic.encode_credentials(
          ENV.fetch("BASIC_AUTH_USERNAME"),
          ENV.fetch("BASIC_AUTH_PASSWORD")
        )
      }
    end

    test "should create follow relationship" do
      assert_difference("UserFollow.count") do
        post follow_api_v1_private_user_url(@user, @target_user),
             params: { target_user_id: @target_user.id }, 
             as: :json, 
             headers: @auth_headers
      end
      assert_response :created
    end

    test "should not create follow relationship for self" do
      assert_no_difference("UserFollow.count") do
        post follow_api_v1_private_user_url(@user, @user),
             params: { target_user_id: @user.id }, 
             as: :json, 
             headers: @auth_headers
      end
      assert_response :unprocessable_entity
    end

    test "should not create duplicate follow relationship" do
      UserFollow.create!(follower: @user, followed: @target_user)

      assert_no_difference("UserFollow.count") do
        post follow_api_v1_private_user_url(@user, @target_user), 
             params: { target_user_id: @target_user.id }, 
             as: :json, 
             headers: @auth_headers
      end
      assert_response :unprocessable_entity
    end

    test "should destroy follow relationship" do
      follow = UserFollow.create(follower: @user, followed: @target_user)

      assert_difference("UserFollow.count", -1) do
        delete unfollow_api_v1_private_user_url(@user, @target_user), 
               params: { target_user_id: @target_user.id }, 
               as: :json, 
               headers: @auth_headers
      end
      assert_response :no_content
    end

    test "should return not found when destroying non-existent follow" do
      delete unfollow_api_v1_private_user_url(@user, @target_user),
             params: { target_user_id: @target_user.id }, 
             as: :json, 
             headers: @auth_headers
      assert_response :not_found
    end
  end
end