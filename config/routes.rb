Rails.application.routes.draw do
  root 'welcome#index'
  resources :tweets, except: [:edit, :update]
  post '/tweets/search' => 'tweets#search'
end

#    tweets GET    /tweets(.:format)          tweets#index
#           POST   /tweets(.:format)          tweets#create
# new_tweet GET    /tweets/new(.:format)      tweets#new
#edit_tweet GET    /tweets/:id/edit(.:format) tweets#edit
#     tweet GET    /tweets/:id(.:format)      tweets#show
#           PATCH  /tweets/:id(.:format)      tweets#update
#           PUT    /tweets/:id(.:format)      tweets#update
#           DELETE /tweets/:id(.:format)      tweets#destroy
