# frozen_string_literal: true

RSpec.shared_context "with basic auth" do
  let(:Authorization) do
    "Basic " + Base64.strict_encode64("#{ENV.fetch('BASIC_AUTH_USERNAME')}:#{ENV.fetch('BASIC_AUTH_PASSWORD')}")
  end
end
