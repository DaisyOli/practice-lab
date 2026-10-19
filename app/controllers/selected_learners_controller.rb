# Switches the fictional learner profile stored in the session. Not authentication.
class SelectedLearnersController < ApplicationController
  def update
    session[:learner_id] = Learner.find(params.expect(:learner_id)).id
    redirect_back_or_to root_path
  end
end
