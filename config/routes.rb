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

#                       GET    /search/:handle(.:format)               tweets#search
# auth_twitter_callback GET    /auth/twitter/callback(.:format)        users#create
#           user_tweets GET    /users/:user_id/tweets(.:format)        tweets#index
#                       POST   /users/:user_id/tweets(.:format)        tweets#create
#        new_user_tweet GET    /users/:user_id/tweets/new(.:format)    tweets#new
#            user_tweet GET    /users/:user_id/tweets/:id(.:format)    tweets#show
#                       DELETE /users/:user_id/tweets/:id(.:format)    tweets#destroy
#    user_tweets_search POST   /users/:user_id/tweets/search(.:format) tweets#search
#                 users POST   /users(.:format)                        users#create
