# Checks one reconstruction attempt. Attempts are not stored in v0.1.
class AttemptsController < ApplicationController
  def create
    @dialogue = Dialogue.find(params[:dialogue_id])
    turn_ids = Array(params[:turn_ids]).map { |id| Integer(id, exception: false) }

    if @dialogue.valid_submission?(turn_ids)
      @check = @dialogue.check(turn_ids)
    else
      @turns = @dialogue.shuffled_turns
      flash.now[:alert] = "Something went wrong with your answer. Please order every turn and submit again."
      render "dialogues/show", status: :unprocessable_entity
    end
  end
end
