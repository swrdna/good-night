require "swagger_helper"

RSpec.describe "Clock In", type: :request do
  path "/private/users/{id}/clock_in" do
    post "Clock in to record sleep session start time" do
      tags "Sleep Sessions"
      consumes "application/json"
      produces "application/json"

      parameter name: :id, in: :path, type: :integer, description: "User ID"
      parameter name: :clock_in, in: :body, schema: {
        type: :object,
        properties: {
          clock_in: {
            type: :object,
            properties: {
              start_time: { type: :string, format: :date_time, example: "2024-06-20T22:00:00Z" }
            }
          }
        },
        required: [ "clock_in" ]
      }
      response "201", "created" do
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
