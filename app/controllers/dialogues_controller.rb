class DialoguesController < ApplicationController
  def index
    @dialogues = Dialogue.order(:cefr_level, :title)
  end

  def show
    @dialogue = Dialogue.find(params[:id])
    @turns = @dialogue.shuffled_turns
  end
end
