Rails.application.routes.draw do
  # auth routes
  post 'signin', to: 'users#signin'
  get '/validate', to: 'users#validate'

  # CRUD routes
  resources :movies, only: [:index, :show, :create]
  resources :users, only: [:index, :show, :create, :update]
  resources :movie_watces, only: [:destroy]

  # custom routes
  get '/movie_search', to: 'movies#search'
  get '/filtered_search', to: 'movies#filter'
  post '/rate_movie', to: 'users#rate_movie'
  post '/forget_movie', to: 'users#forget_movie'
  post '/add_friend', to: 'users#add_friend'
  post '/delete_friend', to: 'users#delete_friend'

end
