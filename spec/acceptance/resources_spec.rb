require 'rails_helper'

resource "Resources", focus: :true do
  header "Accept", "application/json"
  header "Content-Type", "application/json"

  get "/api/v1/resources" do
    example_request "GET /resources" do
      expect(response_status).to eq(200)
    end
  end
end
