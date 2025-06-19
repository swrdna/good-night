require "swagger_helper"

RSpec.describe "Users", type: :request do
  path "/private/users" do
    get "List of users" do
      tags "Users"
      produces "application/json"
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
                  name: { type: :string }
                }
              }
            }
          }
        run_test!
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
              name: {type: :string}
            },
            required: ["name"]
          },
        },
        required: ["user"]
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
                name: { type: :string }
              }
            }
          }
        run_test!
      end
    end
  end

  path "/private/users/{id}/followers" do
    get "List of who follow the current user" do
      tags "Users"
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
                  name: { type: :string }
                }
              }
            }
          }
        run_test!
      end
    end
  end

  path "/private/users/{id}/following" do
    get "List of who followed by current user" do
      tags "Users"
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
                  name: { type: :string }
                }
              }
            }
          }
        run_test!
      end
    end
  end
end
