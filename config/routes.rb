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

  #ユーザー検索
  namespace :search do
    get 'users/index'
  end

  #管理者
  namespace :admin do
    resources :users
  end

  #送受信一覧
  resources :users, except: [:new, :create, :edit, :destroy] do
    resources :transmissions, only: [:index]
    resources :receptions, only: [:index]
    member do
      delete 'image/destroy', to: "users#image_destroy"
    end
  end
end
