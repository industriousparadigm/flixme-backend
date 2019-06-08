Rails.application.routes.draw do
  resources :movies

  get "/movie_search", to: "movies#search"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
