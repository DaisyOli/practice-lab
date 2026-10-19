require "rails_helper"

RSpec.describe "Experiments", type: :request do
  it "lists experiments with their purpose and status" do
    create(:experiment, title: "Dialogue Reconstruction", purpose: "Reorder dialogue turns.", status: "prototype")

    get root_path

    expect(response).to have_http_status(:ok)
    expect(response.body).to include("Dialogue Reconstruction", "Reorder dialogue turns.", "Prototype")
  end
end
