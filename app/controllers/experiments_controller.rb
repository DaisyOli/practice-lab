class ExperimentsController < ApplicationController
  def index
    @experiments = Experiment.order(:id)
  end
end
