# frozen_string_literal: true

require "test_helper"

module Api::V1::Private
  class ClockInControllerTest < ActionDispatch::IntegrationTest
    setup do
      @user = users(:one)
      @auth_headers = {
        "HTTP_AUTHORIZATION" => ActionController::HttpAuthentication::Basic.encode_credentials(
          ENV.fetch("BASIC_AUTH_USERNAME"),
          ENV.fetch("BASIC_AUTH_PASSWORD")
        )
      }
    end

    test "should create new sleep session" do
      assert_difference("SleepSession.count") do
        post api_v1_private_clock_in_url(@user), 
             params: { clock_in: { start_time: Time.current } }, 
             as: :json, 
             headers: @auth_headers
      end
      assert_response :created
    end

    test "should not create new session if active session exists" do
      @user.sleep_sessions.create!(start_time: Time.current)

      assert_no_difference("SleepSession.count") do
        post api_v1_private_clock_in_url(@user), 
             params: { clock_in: { start_time: Time.current } }, 
             as: :json, 
             headers: @auth_headers
      end
      assert_response :unprocessable_entity
    end
  end
end