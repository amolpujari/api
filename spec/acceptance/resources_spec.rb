require 'rails_helper'

resource "Resources", focus: :true do
  header "Host", API_HOST
  header "Accept", "application/json"
  header "Content-Type", "application/json"

  get "/api/v1/resources" do
    parameter :page, "page number in pagination"
    parameter :per_page, "per page items in pagination, valid values are 10, 20, 50. Default: 10"
    parameter :order_by, "sort the result by any field, example name"

    example "GET /resources" do
      13.times{ item = create(:resource) }
      do_request
      expect(response_status).to eq(200)
    end
  end
end
