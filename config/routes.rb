Rails.application.routes.draw do
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  get "up" => "rails/health#show", as: :rails_health_check

  root "experiments#index"

  resource :selected_learner, only: :update

  # Experiment 1: Dialogue Reconstruction
  resources :dialogues, only: [ :index, :show ] do
    resources :attempts, only: :create
  end
end
