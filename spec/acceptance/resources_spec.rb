require 'rails_helper'

resource "Resources", focus: :true do
  header "Host", API_HOST
  header "Accept", "application/json"
  header "Content-Type", "application/json"

  get "/api/v1/resources" do
    parameter :page, "page number in pagination"
    parameter :per_page, "per page items in pagination, valid values are 10, 20, 50. Default: 10"
    parameter :order_by, "sort the result by any field, example name"

    example "GET items" do
      13.times{ item = create(:resource) }
      do_request
      expect(response_status).to eq(200)
    end

    example "GET items on page 2" do
      13.times{ item = create(:resource) }
      do_request page: 2
      expect(response_status).to eq(200)
    end

    example "GET items on page 2 order by name reversed" do
      13.times{ item = create(:resource) }
      do_request page: 2
      expect(response_status).to eq(200)
    end
  end

  get "/api/v1/resources?include=users,abc" do
    example "GET items include users" do
      5.times{  item = create(:resource) }
      Resource.offset(2).each{|rec| 3.times{ create(:user, resource: rec)} }
      do_request
      expect(response_status).to eq(200)
    end
  end

  post "/api/v1/resources" do
    parameter :resource, "resource attributes object, to be created"
    attrs = { name: "new items" }
    let (:resource) { attrs }

    example "POST item" do
      do_request
      expect(response_status).to eq(201)
    end
  end

  get "/api/v1/resources/:id" do
    example "GET item" do
      item = create(:resource)
      id = Resource.pluck(:id).sample
      do_request id: id
      expect(response_status).to eq(200)
    end

    example "GET non existing item" do
      do_request id: 1234
      expect(response_status).to eq(404)
    end
  end

  put "/api/v1/resources/:id" do
    parameter :resource, "resource attributes object, to be updated"
    attrs = { name: "new items updated" }
    let (:resource) { attrs }

    example "PUT item" do
      item = create(:resource)
      id = Resource.pluck(:id).sample
      do_request id: id
      expect(response_status).to eq(201)
    end
  end

  delete "/api/v1/resources/:id" do
    example "DELETE item" do
      item = create(:resource)
      id = Resource.pluck(:id).sample
      do_request id: id
      expect(response_status).to eq(200)
    end

    example "DELETE non existing item" do
      do_request id: 1234
      expect(response_status).to eq(404)
    end
  end
end
