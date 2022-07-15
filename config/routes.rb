Rails.application.routes.draw do
  root 'tweets#new'

  get '/search'          => 'tweets#search'
end
