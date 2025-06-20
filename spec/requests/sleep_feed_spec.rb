require "swagger_helper"

RSpec.describe "Sleep Feeds", type: :request do
  include_context "with basic auth"

  path "/private/users/{id}/sleep_feeds" do
    get "Following user's sleep activity" do
      tags "Sleep Feed"
      produces "application/json"
      parameter name: :id, in: :path, type: :integer, description: "User ID"
      response "200", "ok" do
        schema type: :object,
          properties: {
            data: {
              type: :array,
              items: {
                type: :object,
                properties: {
                  id: { type: :string },
                  type: { type: :string },
                  attributes: {
                    type: :object,
                    properties: {
                      id: { type: :integer },
                      start_time: { type: :string },
                      end_time: { type: :string },
                      duration: { type: :integer },
                      duration_text: { type: :string },
                      user: {
                        type: :object,
                        properties: {
                          id: { type: :integer },
                          name: { type: :string }
                        }
                      }
                    }
                  }
                }
              }
            }
          }

        let(:user) { User.create!(name: "User A") }
        let(:id) { user.id }
        let(:followed_user) { User.create!(name: "User B") }
        let!(:follow) { UserFollow.create!(follower: user, followed: followed_user) }
        let!(:sleep_session) { SleepSession.create!({ start_time: Time.current, end_time: Time.current+8.hours, user: followed_user, duration: 60 * 60 * 8 }) }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data.size).to be(1)
          expect(data["data"][0]["attributes"]["user"]["id"]).to be(followed_user.id)
        end
      end
    end
  end

  path "/public/sleep_feeds" do
    get "All users's sleep activity" do
      tags "Sleep Feed"
      produces "application/json"
      response "200", "ok" do
        schema type: :object,
          properties: {
            data: {
              type: :array,
              items: {
                type: :object,
                properties: {
                  id: { type: :string },
                  type: { type: :string },
                  attributes: {
                    type: :object,
                    properties: {
                      id: { type: :integer },
                      start_time: { type: :string },
                      end_time: { type: :string },
                      duration: { type: :integer },
                      duration_text: { type: :string },
                      user: {
                        type: :object,
                        properties: {
                          id: { type: :integer },
                          name: { type: :string }
                        }
                      }
                    }
                  }
                }
              }
            }
          }

        let(:user) { User.create!(name: "User A") }
        let!(:sleep_session) { SleepSession.create!({ start_time: Time.current, end_time: Time.current+8.hours, user: user, duration: 60 * 60 * 8 }) }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data.size).to be(1)
          expect(data["data"][0]["attributes"]["user"]["id"]).to be(user.id)
        end
      end
    end
  end
end
