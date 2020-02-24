Rails.application.routes.draw do

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'thanks#index'
  resources :thanks, except: %i(index, show)
  namespace :search do
    get 'users/index'
  end
  namespace :admin do
    resources :users
  end

  resources :users, only: %i(index) do
    resources :mypages, only: %i(index)
  end
end
