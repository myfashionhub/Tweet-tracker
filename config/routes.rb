Rails.application.routes.draw do
  root 'welcome#index'

  # Important: portfolio dependency
  get '/search/:handle'        => 'tweets#search'
  get '/search/:handle/:keyword' => 'tweets#search_topic'
  get '/search_hashtag/:hashtag' => 'tweets#search_hashtag'

  get '/auth/twitter/callback' => 'sessions#create'
  get '/logout'                => 'sessions#destroy'

  resources :users, only: [:show, :create] do
    resources :tweets, except: [:edit, :update]
    post '/tweets/find' => 'tweets#find'
  end
end
