require "swagger_helper"

RSpec.describe "Users", type: :request do
  path "/private/users" do
    get "Retrieves list of users" do
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

          let(:users) { create_list(:user, 3) }
          run_test!
      end
    end
  end
end
