Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }

  # Custom authentication routes
  devise_scope :user do
    post "register", to: "users/registrations#create"
    post "login", to: "users/sessions#create"
    delete "logout", to: "users/sessions#destroy"
    post "refresh_token", to: "users/sessions#refresh_token"
  end

  resources :tasks
  root "tasks#index"
end
