require "rails_helper"

RSpec.describe "Selected learner", type: :request do
  it "remembers the chosen fictional learner in the session" do
    matteo = create(:learner, name: "Matteo", cefr_level: "B1")

    patch selected_learner_path, params: { learner_id: matteo.id }
    follow_redirect!

    expect(response.body).to include(%(<option selected="selected" value="#{matteo.id}">Matteo — B1</option>))
  end

  it "returns 404 for an unknown learner" do
    patch selected_learner_path, params: { learner_id: 0 }

    expect(response).to have_http_status(:not_found)
  end
end
