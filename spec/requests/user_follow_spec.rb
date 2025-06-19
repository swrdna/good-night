require "swagger_helper"

RSpec.describe "Follow and unfollow user", type: :request do
  path "/private/users/{id}/follow/{target_user_id}" do
    post "Follow user" do
      tags "Follow"
      consumes "application/json"
      produces "application/json"
      parameter name: :id, in: :path, type: :integer, description: "user_id"
      parameter name: :target_user_id, in: :path, type: :integer, description: "target_user_id"
      response "200", "ok" do
        schema type: :object,
          properties: {
            id: { type: :string },
            type: { type: :string },
            attributes: {
              type: :object,
              properties: {
                followed_id: { type: :integer },
                followed_name: { type: :string },
              }
            }
          }

        run_test!
      end
    end
  end

  path "/private/users/{id}/unfollow/{target_user_id}" do
    delete "Unfollow user" do
      tags "Unfollow"
      parameter name: :id, in: :path, type: :integer, description: "user_id"
      parameter name: :target_user_id, in: :path, type: :integer, description: "target_user_id"

      response "204", "no content" do
        run_test!
      end
    end
  end
end
