Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    confirmations: "users/confirmations",
    passwords: "users/passwords"
  }
  devise_scope :user do
    patch "users/confirmation", to: "users/confirmations#confirm"
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'thanks#index'
  resources :thanks, except: %i(index, show)
  namespace :search do
    get 'users/index'
  end
  namespace :admin do
    resources :users
  end
end
