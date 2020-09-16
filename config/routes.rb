Rails.application.routes.draw do
  root 'letters/receive#index'

  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    confirmations: "users/confirmations",
    passwords: "users/passwords"
  }
  devise_scope :user do
    patch "users/confirmation", to: "users/confirmations#confirm"
  end

  namespace :api do
    get "users/login" # ログインしているユーザーのデータを取得
    post "users/:user_id/community", to: 'companies#create' # コミュニティ登録
    patch "users/:user_id/community", to: 'companies#update' # コミュニティ更新
    get "users/:user_id/company/belong_to", to: 'companies#belong_to_company' #ログインしているユーザーの所属しているコミュニティデータ取得
    get "users/:user_id/companies", to: 'companies#index' # コミュニティ全取得
    post "users/:user_id/groups", to: 'groups#create' # グループ登録
    get "users/:user_id/groups", to: 'groups#index' # 会社に紐づいているグループを取得
    post "users/:user_id/group_users", to: 'group_users#create' #参加申請
    get "search/users", to: 'search/users#index' # ユーザー検索
    post "users/:user_id/thanks", to: 'thanks#create' # メッセージ作成
    get "users/:user_id/letters/send", to: 'letters/send#index' # 送信メッセージを取得
    get "users/:user_id/letters/receive", to: 'letters/receive#index' # 受信メッセージを取得
    patch "users/:user_id/letters/send/:id", to: 'letters/send#update' # メッセージ更新
    delete "users/:user_id/letters/send/:id", to: 'letters/send#destroy' # メッセージ削除
    namespace :admin do
      get 'users/index'
      patch 'users/update'
      patch 'users/destroy',to: 'users#destroy'
      get 'requests/update'
      patch 'requests/update'
      patch 'requests/destroy',to: 'requests#destroy'
    end
    namespace :lists do
      get 'groups/index'
    end
  end

  resources :users, except: [:new, :create, :destroy] do
    namespace :letters do
      get 'receive'    , to: 'receive#index'
      get 'send'       , to: 'send#index'
    end
      get 'community'  , to: 'groups#index'
      get 'admin'      , to: 'admin/users#index'
      get 'other'      , to: 'users/other#index'
    # member do
    #   patch "login_update", to: "user/login#update"
    #   delete 'image/destroy', to: "users#image_destroy"
    # end

  end

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



  namespace :letters do
    get "timer", to:"timer#index"
  end

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

  
end
