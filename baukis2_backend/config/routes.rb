Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # おそらく、route.rbで使うものは以下の通り。
  # get : 取得
  # post : 追加
  # patch : 更新(updateどこやった！？)
  # delete : 削除

  config = Rails.application.config.baukis2_pack

  constraints host: config[:staff][:host] do
  # 上のコードは以下に同じ。config/initializers/baukis2_pack.rbのデータを参照しているのだ。
  # constraints host: "baukis2.example.com" do
    namespace :staff, path: config[:staff][:path] do
      # config/initializers/baukis2_pack.rbのデータを参照し、以下コードと同じ処理になるようになった。
    # namespace :staff, path:"" do
    #   # 「path:""」を定めることで、先頭の「staff/」がなくなる。
      root "top#index"
      get "login" => "sessions#new", as: :login

      resource :session, only:[:create, :destroy]
      # :session(ログイン機能)も一つだけなので単数系は取る。
      resource :account, except:[:new, :create, :destroy]
      # 「単数のみ」のresourcesとして、resourceがある。
      # 余談ながら、accountは本アプリでは作成/編集/削除は管理者に一任するため除外する。

    end
  end

  # namespace :staff do
  # namespace :staff, path:"" do
  # # 「path:""」を定めることで、先頭の「staff/」がなくなる。
  #   root "top#index"
  #   get "login" => "sessions#new", as: :login
  #     post "session" => "sessions#create", as: :session
  #   delete "session" => "sessions#destroy"
  #
  #   resource :staff_members, only[:create, :destroy]
  #   # :staff_members(ログイン機能)も一つだけなので単数系は取る。
  #   resource :account, except[:new, :create, :destroy]
  #   # 「単数のみ」のresourcesとして、resourceがある。
  #   # 余談ながら、accountは本アプリでは作成/編集/削除は管理者に一任するため除外する。
  # end

  constraints host: config[:admin][:host] do
    namespace :admin do
      root "top#index"
        get "login" => "sessions#new", as: :login
        # post "session" => "sessions#create", as: :session
        # delete "session" => "sessions#destroy"

          # get "staff_members" => "staff_members#index"
          # get "staff_members/:id" => "staff_members#show"
          # get "staff_members/new" => "staff_members#new"
          # get "staff_members/:id/edit" => "staff_members#edit"
          # post "staff_members" => "staff_members#create"
          # patch "staff_members/:id" => "staff_members#update"
          # delete "staff_members/:id" => "staff_members#destroy"
          # resources :staff_members
          # 「resources :モデル名」は、その上の7種類のルート処理の機能を一任しているのだ。
          # 使用する機能を限定させたい時は、only(これだけ)、except(これ以外)を使うといい。以下の通り。
          # resources :staff_members, only[:index, :new, :create]
          # resources :staff_members, except[:show, :destroy]

        resource :session, only:[:create, :destroy]
        resources :staff_members

      end

  end


  # namespace :admin do
  #   root "top#index"
  #   get "login" => "sessions#new", as: :login
  #     post "session" => "sessions#create", as: :session
  #   delete "session" => "sessions#destroy"
  #
  #   # get "staff_members" => "staff_members#index"
  #   # get "staff_members/:id" => "staff_members#show"
  #   # get "staff_members/new" => "staff_members#new"
  #   # get "staff_members/:id/edit" => "staff_members#edit"
  #   # post "staff_members" => "staff_members#create"
  #   # patch "staff_members/:id" => "staff_members#update"
  #   # delete "staff_members/:id" => "staff_members#destroy"
  #   # resources :staff_members
  #   # 「resources :モデル名」は、その上の7種類のルート処理の機能を一任しているのだ。
  #   # 使用する機能を限定させたい時は、only(これだけ)、except(これ以外)を使うといい。以下の通り。
  #   # resources :staff_members, only[:index, :new, :create]
  #   # resources :staff_members, except[:show, :destroy]
  #
  #   resource :staff_members, only[:create, :destroy]
  #   resource :account, except[:new, :create, :destroy]
  #
  #
  # end


  constraints host: config[:customer][:host] do
    namespace :customer, path: config[:customer][:path] do
      root "top#index"
    end
  end

end
