require "swagger_helper"

RSpec.describe "Clock In", type: :request do
  include_context "with basic auth"

  path "/private/users/{id}/clock_in" do
    post "Clock in to record sleep session start time" do
      tags "Sleep Sessions"
      consumes "application/json"
      produces "application/json"

      parameter name: :id, in: :path, type: :integer, description: "User ID"
      parameter name: :Authorization, in: :header, type: :string, required: true, description: "Basic Auth credentials"
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
            data: {
              type: :object,
              properties: {
                id: { type: :string },
                type: { type: :string },
                attributes: {
                  type: :object,
                  properties: {
                    id: { type: :integer },
                    start_time: { type: :string },
                    end_time: { type: :string, nullable: true },
                    duration: { type: :integer, nullable: true },
                    duration_text: { type: :string, nullable: true }
                  }
                }
              }
            }
          }
          

        let(:user) { User.create!(name: 'User A') }
        let(:id) { user.id }
        let(:clock_in) { { clock_in: { start_time: Time.current.iso8601 } } }

        run_test! do
          expect(SleepSession.count).to eq(1)
        end
      end

      response "422", "unprocessable content" do
        message = ["Cannot create new session while there is an active session"]
        schema type: :object,
          properties: {
            data: {
              type: :object,
              properties: {
                message: { type: :array, example:  message}
              }
            }
          }

        let(:user) { User.create!(name: 'User A') }
        let(:id) { user.id }
        let!(:open_session) { user.sleep_sessions.create!(start_time: 2.hours.ago) }
        let(:clock_in) { { clock_in: { start_time: Time.current.iso8601 } } }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['message']).to eq(message)
          expect(response.status).to eq(422)
        end
      end
    end
  end
end
