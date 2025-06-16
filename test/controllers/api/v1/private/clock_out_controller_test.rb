# frozen_string_literal: true

require "test_helper"

module Api::V1::Private
  class ClockOutControllerTest < ActionDispatch::IntegrationTest
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

    test "should update sleep session with end time" do
      patch api_v1_private_clock_out_url(@user), 
            params: { clock_out: { end_time: Time.current } }, 
            as: :json, 
            headers: @auth_headers
      assert_response :success
    end
  end
end