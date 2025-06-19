require "swagger_helper"

RSpec.describe "Sleep Feeds", type: :request do
  path "/private/users/{id}/sleep_feeds" do
    get "Following user's sleep activity" do
      tags "Sleep Feed"
      produces "application/json"
      parameter name: :id, in: :path, type: :integer, description: "User ID"
      response "200", "ok" do
        schema type: :object,
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

        run_test!
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

        run_test!
      end
    end
  end
end
