# config/routes.rb

Rails.application.routes.draw do
  get '/countries', to: 'countries#index', as: 'countries'
  get '/countries/:name', to: 'countries#show', as: 'country'
  get 'countries/show'
  get '/search', to: 'countries#search', as: 'search_countries'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "countries#index"
end
