Rails.application.routes.draw do

  namespace :api do
    namespace :admin do
      get 'requests/update'
    end
  end
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
    resources :tops
  end

  # #送受信一覧
  resources :users, except: [:new, :create, :destroy] do
    namespace :letters do
      get 'receive', to: 'receive#index'
      get 'send', to: 'send#index'
    end
    resources :transmissions, only: [:index]
      member do
        patch "login_update", to: "user/login#update"
        delete 'image/destroy', to: "users#image_destroy"
      end
  end

  namespace :letters do
    get "timer", to:"timer#index"
  end

  # resources :transmissions, only: [:index]
  #   member do
  #     patch "login_update", to: "user/login#update"
  #     delete 'image/destroy', to: "users#image_destroy"
  #   end
  # end

  namespace :user do
    get 'groups', to: 'group#index'
    get 'groups/search', to: 'group#search'
    post 'groups', to: 'group#create'
    get 'groups/belongs_group', to:'group#belongs_group'
    delete 'groups/destroy', to: 'group#destroy'
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

  namespace :api do
    namespace :admin do
      get 'users/index'
      patch 'users/update'
      patch 'users/destroy',to: 'users#destroy'
      patch 'requests/update'
      patch 'requests/destroy',to: 'requests#destroy'
    end
    namespace :lists do
      get 'groups/index'
    end
  end
end
