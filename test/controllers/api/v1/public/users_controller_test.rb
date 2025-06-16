require "test_helper"

module Api::V1::Public
  class UsersControllerTest < ActionDispatch::IntegrationTest
    test "should get index" do
      get api_v1_public_users_url, as: :json
      assert_response :success
    end
  end
end
