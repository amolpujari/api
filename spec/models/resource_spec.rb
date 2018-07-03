require 'rails_helper'

describe Resource do
  it ".order_by" do
    expect(Resource.order_by_columns).to eq(["name"])
  end

  it ".permit" do
    expect(Resource.permitted_columns).to eq([:name])
  end
end
