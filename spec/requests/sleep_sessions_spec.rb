require "swagger_helper"

RSpec.describe "Users", type: :request do
  path "/private/users/{id}/sleep_sessions" do
    get "List of user's sleep sessions" do
      tags "Sleep Sessions"
      produces "application/json"
      parameter name: :id, in: :path, type: :integer, description: "user_id"
      response "200", "ok" do
        schema type: :array,
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
                  duration_text: { type: :string }
                }
              }
            }
          }
        run_test!
      end
    end
  end

  path "/private/users/{user_id}/sleep_sessions/{id}" do
    put "Update existing sleep session" do
      tags "Sleep Sessions"
      consumes "application/json"
      produces "application/json"
      parameter name: :user_id, in: :path, type: :integer, description: "user_id"
      parameter name: :id, in: :path, type: :integer, description: "sleep_session_id"
      parameter name: :sleep_session, in: :body, schema: {
        type: :object,
        properties: {
          sleep_session: {
            type: :object,
            properties: {
              start_time: { type: :string },
              end_time: { type: :string }
            },
            required: [ "start_time", "end_time" ]
          }
        },
        required: [ "sleep_session" ]
      }

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
                duration_text: { type: :string }
              }
            }
          }
        run_test!
      end
    end

    delete "Delete sleep session" do
      tags "Sleep Sessions"
      parameter name: :user_id, in: :path, type: :integer, description: "user_id"
      parameter name: :id, in: :path, type: :integer, description: "sleep_session_id"

      response "204", "no content" do
        run_test!
      end
    end
  end
end
