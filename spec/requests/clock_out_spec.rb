require "swagger_helper"

RSpec.describe "Clock Out", type: :request do
  include_context "with basic auth"

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

      response "200", "clock out success" do
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
                    end_time: { type: :string },
                    duration: { type: :integer },
                    duration_text: { type: :string }
                  }
                }
              }
            }
          }


        let(:user) { User.create!(name: 'User A') }
        let(:id) { user.id }
        let!(:open_session) { user.sleep_sessions.create!(start_time: 2.hours.ago) }
        let(:clock_out) { { clock_out: { end_time: Time.current.iso8601 } } }

        run_test! do
          expect(SleepSession.first.end_time).not_to be_nil
          expect(SleepSession.first.duration).not_to be_nil
        end
      end

      response "422", "clock out not processed" do
        message = [ "End time must be greater than start time" ]
        schema type: :object,
          properties: {
            data: {
              type: :object,
              properties: {
                message: { type: :array, example: message }
              }
            }
          }

        let(:user) { User.create!(name: 'User A') }
        let(:id) { user.id }
        let!(:open_session) { user.sleep_sessions.create!(start_time: 2.hours.ago) }
        let(:clock_out) { { clock_out: { end_time: 3.hours.ago } } }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['message']).to eq(message)
        end
      end
    end
  end
end
