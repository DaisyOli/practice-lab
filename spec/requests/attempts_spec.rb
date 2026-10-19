require "rails_helper"

RSpec.describe "Dialogue reconstruction attempts", type: :request do
  let(:dialogue) { create(:dialogue, :with_turns) }
  let(:correct_ids) { dialogue.turns.ids }

  it "congratulates the learner when the order is correct" do
    post dialogue_attempts_path(dialogue), params: { turn_ids: correct_ids }

    expect(response).to have_http_status(:ok)
    expect(response.body).to include("Well done!")
  end

  it "reports how many turns are in the right place and offers a retry" do
    first, second, third, fourth = correct_ids
    post dialogue_attempts_path(dialogue), params: { turn_ids: [ second, first, third, fourth ] }

    expect(response.body).to include("2 of 4 turns are in the right place", "Try again")
  end

  it "re-renders the exercise when the submission is incomplete" do
    post dialogue_attempts_path(dialogue), params: { turn_ids: correct_ids.first(2) }

    expect(response).to have_http_status(:unprocessable_entity)
    expect(response.body).to include("Check my order")
  end

  it "handles a submission with no turns" do
    post dialogue_attempts_path(dialogue)

    expect(response).to have_http_status(:unprocessable_entity)
  end

  it "rejects non-numeric turn ids without crashing" do
    post dialogue_attempts_path(dialogue), params: { turn_ids: correct_ids.first(3).map(&:to_s) + [ "abc" ] }

    expect(response).to have_http_status(:unprocessable_entity)
  end
end
