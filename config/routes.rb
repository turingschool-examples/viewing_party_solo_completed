Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")


  root "welcome#index"
  get '/register', to: 'users#new', as: 'register_user'

  resources :users, only: [:show, :create] do
      get "/discover", to: "discover#index"
      post "/movies", to: "movies#results"
      get "/movies/:movie_id", to: "movies#show"
  end

end
