require "swagger_helper"

RSpec.describe "Users", type: :request do
  include_context "with basic auth"

  path "/private/users/{id}/sleep_sessions" do
    get "List of user's sleep sessions" do
      tags "Sleep Sessions"
      produces "application/json"
      parameter name: :id, in: :path, type: :integer, description: "user_id"
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
                    duration_text: { type: :string }
                  }
                }
              }
            }
          }
        }

        let(:user) { User.create!(name: 'User A') }
        let(:id) { user.id }
        let!(:sleep_session) { SleepSession.create!({ start_time: Time.current, end_time: Time.current+8.hours, user: user, duration: 60 * 60 * 8 }) }

        run_test! do
          expect(SleepSession.count).to eq(1)
        end
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
        let(:user_id) { user.id }
        let!(:existing_sleep_session) { SleepSession.create!({ start_time: Time.current, end_time: Time.current+8.hours, user: user, duration: 60 * 60 * 8 }) }
        let(:id) { existing_sleep_session.id }
        let(:sleep_session) { { sleep_session: { end_time: Time.current+10.hours } } }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data.size).to be(1)
          expect(data["data"]['attributes']['duration']).to be(60 * 60 * 10)
        end
      end

      response "422", "unprocessed content" do
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
        let(:user_id) { user.id }
        let!(:existing_sleep_session) { SleepSession.create!({ start_time: Time.current, end_time: Time.current+8.hours, user: user, duration: 60 * 60 * 8 }) }
        let(:id) { existing_sleep_session.id }
        let(:sleep_session) { { sleep_session: { end_time: existing_sleep_session.start_time-3.hours } } }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['message']).to eq(message)
        end
      end

      response "422", "unprocessed content when start_time and end_time nil" do
        message = [ "Start time can't be blank", "End time can't be blank" ]
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
        let(:user_id) { user.id }
        let!(:existing_sleep_session) { SleepSession.create!({ start_time: Time.current, end_time: Time.current+8.hours, user: user, duration: 60 * 60 * 8 }) }
        let(:id) { existing_sleep_session.id }
        let(:sleep_session) { { sleep_session: { start_time: nil, end_time: nil } } }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['message']).to eq(message)
        end
      end
    end

    delete "Delete sleep session" do
      tags "Sleep Sessions"
      parameter name: :user_id, in: :path, type: :integer, description: "user_id"
      parameter name: :id, in: :path, type: :integer, description: "sleep_session_id"

      response "204", "no content" do
        let(:user) { User.create!(name: 'User A') }
        let(:user_id) { user.id }
        let!(:existing_sleep_session) { SleepSession.create!({ start_time: Time.current, end_time: Time.current+8.hours, user: user, duration: 60 * 60 * 8 }) }
        let(:id) { existing_sleep_session.id }

        run_test! do |response|
          expect(response.status).to be(204)
        end
      end
    end
  end
end
