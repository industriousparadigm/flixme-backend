Rails.application.routes.draw do
  # auth routes
  post 'signin', to: 'users#signin'

  # CRUD routes
  resources :movies, only: [:index, :show, :create]
  resources :users, only: [:show]
  resources :movie_watces, only: [:destroy]

  # custom routes
  get "/movie_search", to: "movies#search"
  post "/rate_movie", to: "users#rate_movie"
  post "/forget_movie", to: "users#forget_movie"
end
