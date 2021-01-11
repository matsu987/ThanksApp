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

  resources :users, except: [:new, :create, :destroy] do
    namespace :letters do
      get 'receive'    , to: 'receive#index'     # 受信一覧ページ
      get 'send'       , to: 'send#index'        # 送信一覧ページ
    end
      get 'community'  , to: 'groups#index'      # 組織設定ページ
      get 'admin'      , to: 'admin/users#index' # 管理者設定ページ
      get 'other'      , to: 'users/other#index' # その他ページ
    # member do
    #   patch "login_update", to: "user/login#update"
    #   delete 'image/destroy', to: "users#image_destroy"
    # end

  end

  namespace :api do
    # ユーザー処理
    get    "users/login"                     , to: 'users#login'                 # ログインしているユーザーのデータを取得
    delete "users/:id/signout"              , to: 'users#signout'               # ログアウト
    delete "users/:id"                       , to: 'users#destroy'               # ユーザー退会

    # 組織処理
    post   "users/:user_id/community"        , to: 'companies#create'            # 組織登録
    patch  "users/:user_id/community"        , to: 'companies#update'            # 組織更新
    get    "users/:user_id/company/belong_to", to: 'companies#belong_to_company' # ログインしているユーザーの所属している組織データ取得
    get    "users/:user_id/companies"        , to: 'companies#index'             # 組織全取得

    # グループ処理
    post   "users/:user_id/groups"           , to: 'groups#create'               # グループ登録
    get    "users/:user_id/groups"           , to: 'groups#index'                # 会社に紐づいているグループを取得
    post   "users/:user_id/group_users"      , to: 'group_users#create'          # 組織内のグループ参加申請
    get    "search/users"                    , to: 'search/users#index'          # ユーザー検索

    # メッセージ処理
    post   "users/:user_id/thanks"           , to: 'thanks#create'               # メッセージ作成

    # メッセージ受信処理
    get    "users/:user_id/letters/receive"  , to: 'letters/receive#index'       # 受信メッセージを取得

    # メッセージ送信処理
    get    "users/:user_id/letters/send"     , to: 'letters/send#index'          # 送信メッセージを取得
    patch  "users/:user_id/letters/send/:id" , to: 'letters/send#update'         # メッセージ更新
    delete "users/:user_id/letters/send/:id" , to: 'letters/send#destroy'        # メッセージ削除

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

  namespace :letters do
    get "timer", to:"timer#index"
  end

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

  namespace :user do
    get 'groups', to: 'group#index'
    get 'groups/search', to: 'group#search'
    post 'groups', to: 'group#create'
    get 'groups/belongs_group', to:'group#belongs_group'
    delete 'groups/destroy', to: 'group#destroy'
  end

  resources :groups, only: [:index, :new]
end
