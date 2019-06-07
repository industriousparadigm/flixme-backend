class Movie < ApplicationRecord
  has_many :movie_genres
  has_many :genres, through: :movie_genres

  has_many :movie_watches
  has_many :users, through: :movie_watches
  
end
