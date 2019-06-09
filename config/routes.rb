Rails.application.routes.draw do
  # CRUD routes
  resources :movies, only: [:index, :show, :create]
  resources :users, only: [:show]

  # custom routes
  get "/movie_search", to: "movies#search"
  post "/rate_movie", to: "users#rate_movie"
end
