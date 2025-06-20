require "swagger_helper"

RSpec.describe "Users", type: :request do
  include_context "with basic auth"

  path "/private/users" do
    get "List of users" do
      tags "Users"
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
                      name: { type: :string }
                    }
                  }
                }
              }
            }
          }
      
        let!(:users) { User.create!([{name: "User A"}, {name: "User B"}]) }
      
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data["data"].size).to be(User.count)
          expect(response.status).to eq(200)
        end
      end
    end

    post "Create a user" do
      tags "Users"
      consumes "application/json"
      produces "application/json"

      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              name: { type: :string }
            },
            required: [ "name" ]
          }
        },
        required: [ "user" ]
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
                    name: { type: :string }
                  }
                }
              }
            }
          }

        let(:user) { { user: { name: "User A" } } }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(User.find_by(name: "User A")).to be_present
          expect(response.status).to eq(201)
        end
      end

      response "422", "unprocessed content" do
        message = ["Name can't be blank"]
        schema type: :object,
          properties: {
            data: {
              type: :object,
              properties: {
                message: { type: :array, example: message }
              }
            }
          }

        let(:user) { { user: { name: nil } } }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['message']).to eq(message)
          expect(response.status).to eq(422)
        end
      end
    end
  end

  path "/private/users/{id}/followers" do
    get "List of who follow the current user" do
      tags "Users"
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
                    name: { type: :string }
                  }
                }
              }
            }
          }
        }

        let(:user) { User.create!(name: 'User A') }
        let(:id) { user.id }
        let(:follower_user) { User.create!(name: 'User B') }
        let!(:follow) { UserFollow.create!(follower: follower_user, followed: user) }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data["data"][0]["attributes"]["id"]).to eq(follower_user.id)
          expect(response.status).to eq(200)
        end
      end
    end
  end

  path "/private/users/{id}/following" do
    get "List of who followed by current user" do
      tags "Users"
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
                      name: { type: :string }
                    }
                  }
                }
              }
            }
          }

        let(:user) { User.create!(name: 'User A') }
        let(:id) { user.id }
        let(:followed_user) { User.create!(name: 'User B') }
        let!(:follow) { UserFollow.create!(follower: user, followed: followed_user) }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data["data"][0]["attributes"]["id"]).to eq(followed_user.id)
          expect(response.status).to eq(200)
        end
      end
    end
  end
end
