# frozen_string_literal: true

require "test_helper"

module Api::V1::Private
  class SleepSessionsControllerTest < ActionDispatch::IntegrationTest
    setup do
      @user = users(:one)
      @sleep_session = sleep_sessions(:one)
      @auth_headers = {
        "HTTP_AUTHORIZATION" => ActionController::HttpAuthentication::Basic.encode_credentials(
          ENV.fetch("BASIC_AUTH_USERNAME"),
          ENV.fetch("BASIC_AUTH_PASSWORD")
        )
      }
    end

    test "should get index" do
      get api_v1_private_user_sleep_sessions_url(@user), as: :json, headers: @auth_headers
      assert_response :success
    end

    test "should show sleep_session" do
      get api_v1_private_user_sleep_session_url(@user, @sleep_session), as: :json, headers: @auth_headers
      assert_response :success
    end

    test "should update sleep_session" do
      patch api_v1_private_user_sleep_session_url(@user, @sleep_session), 
            params: { sleep_session: { end_time: @sleep_session.end_time, start_time: @sleep_session.start_time } }, 
            as: :json, 
            headers: @auth_headers
      assert_response :success
    end

    test "should destroy sleep_session" do
      assert_difference("SleepSession.count", -1) do
        delete api_v1_private_user_sleep_session_url(@user, @sleep_session), 
               as: :json, 
               headers: @auth_headers
      end

      assert_response :no_content
    end

    test "should not show sleep_session from different user" do
      other_user = users(:two)
      get api_v1_private_user_sleep_session_url(other_user, @sleep_session), 
          as: :json, 
          headers: @auth_headers
      assert_response :not_found
    end

    test "should not update sleep_session from different user" do
      other_user = users(:two)
      patch api_v1_private_user_sleep_session_url(other_user, @sleep_session), 
            params: { sleep_session: { end_time: Time.current } }, 
            as: :json, 
            headers: @auth_headers

      assert_response :not_found
    end
  end
end