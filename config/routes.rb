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
    get 'groups/index'
  end

  #管理者
  namespace :admin do
    resources :users
  end

  #送受信一覧
  resources :users, except: [:new, :create, :destroy] do
    resources :transmissions, only: [:index]
    resources :receptions, only: [:index]
    member do
      patch "login_update", to: "user/login#update"
      delete 'image/destroy', to: "users#image_destroy"
    end
  end

  resources :companies, only: [:index, :create, :update]
  resources :groups, only: [:index, :new, :create, :edit, :update] do
    collection do
      get "depart_join", to: "groups#depart_join"
      get "get_group", to: "groups#get_group"
      get "admin",   to: "groups#admin"
      patch "depart_join_create", to: "groups#depart_join_create"
      patch "depart_request_create", to: "groups#depart_request_create"
    end
  end
end
