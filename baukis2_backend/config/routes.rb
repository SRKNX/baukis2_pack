Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # おそらく、route.rbで使うものは以下の通り。
  # get : 取得
  # post : 追加
  # patch : 更新(updateどこやった！？)
  # delete : 削除

  namespace :staff do
    root "top#index"
    get "login" => "sessions#new", as: :login
      post "session" => "sessions#create", as: :session
    delete "session" => "sessions#destroy"
  end

  namespace :admin do
    root "top#index"
    get "login" => "sessions#new", as: :login
      post "session" => "sessions#create", as: :session
    delete "session" => "sessions#destroy"    
  end

  namespace :customer do
    root "top#index"
  end

end
