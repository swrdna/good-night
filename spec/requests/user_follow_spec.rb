require "swagger_helper"

RSpec.describe "Follow and unfollow user", type: :request do
  include_context "with basic auth"

  path "/private/users/{id}/follow/{target_user_id}" do
    post "Follow user" do
      tags "Follow"
      consumes "application/json"
      produces "application/json"
      parameter name: :id, in: :path, type: :integer, description: "user_id"
      parameter name: :target_user_id, in: :path, type: :integer, description: "target_user_id"
      response "201", "created" do
        schema type: :object,
          properties: {
            data: {
              type: :object,
              properties: {
                id: { type: :string },
                type: { type: :string },
                attributes: {
                  type: :object,
                  properties: {
                    followed_id: { type: :integer },
                    followed_name: { type: :string }
                  }
                }
              }
            }
          }

        let(:user) { User.create!(name: "User A") }
        let(:id) { user.id }
        let(:followed_user) { User.create!(name: "User B") }
        let(:target_user_id) { followed_user.id }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(UserFollow.where({ followed_id: followed_user.id, follower_id: user.id }).size).to be(1)
          expect(data["data"]["attributes"]["followed_id"]).to be(followed_user.id)
        end
      end

      response "422", "unprocessed content" do
        message = [ "Follower You are already following this user" ]
        schema type: :object,
          properties: {
            data: {
              type: :object,
              properties: {
                message: { type: :array, example: message }
              }
            }
          }

        let(:user) { User.create!(name: "User A") }
        let(:id) { user.id }
        let(:followed_user) { User.create!(name: "User B") }
        let(:target_user_id) { followed_user.id }
        let!(:follow) { UserFollow.create!(follower: user, followed: followed_user) }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data["message"]).to eq(message)
          expect(response.status).to eq(422)
        end
      end
    end
  end

  path "/private/users/{id}/unfollow/{target_user_id}" do
    delete "Unfollow user" do
      tags "Unfollow"
      parameter name: :id, in: :path, type: :integer, description: "user_id"
      parameter name: :target_user_id, in: :path, type: :integer, description: "target_user_id"

      response "204", "no content" do
        let(:user) { User.create!(name: "User A") }
        let(:id) { user.id }
        let(:followed_user) { User.create!(name: "User B") }
        let(:target_user_id) { followed_user.id }
        let!(:follow) { UserFollow.create!(follower: user, followed: followed_user) }

        run_test! do
          expect(UserFollow.where({ followed_id: followed_user.id, follower_id: user.id }).size).to be(0)
        end
      end
    end
  end
end
