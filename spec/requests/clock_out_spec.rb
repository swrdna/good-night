require "swagger_helper"

RSpec.describe "Clock Out", type: :request do
  path "/private/users/{id}/clock_out" do
    put "Clock put to end the sleep session" do
      tags "Sleep Sessions"
      consumes "application/json"
      produces "application/json"

      parameter name: :id, in: :path, type: :integer, description: "User ID"
      parameter name: :clock_out, in: :body, schema: {
        type: :object,
        properties: {
          clock_out: {
            type: :object,
            properties: {
              end_time: { type: :string, format: :date_time, example: "2024-06-20T22:00:00Z" }
            }
          }
        },
        required: [ "clock_out" ]
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
  end
end
