class Movie < ApplicationRecord
  has_many :movie_genres
  has_many :genres, through: :movie_genres

  has_many :movie_watches
  has_many :users, through: :movie_watches

  def self.add_to_database(tmdb_movie)
    movie = Movie.find_or_create_by(id: tmdb_movie[:id]) do |m|
      m.adult = tmdb_movie[:adult],
      m.title = tmdb_movie[:title],
      m.poster_path = tmdb_movie[:poster_path],
      m.overview = tmdb_movie[:overview],
      m.release_date = tmdb_movie[:release_date],
      m.original_language = tmdb_movie[:original_language],
      m.vote_count = tmdb_movie[:vote_count],
      m.vote_average = tmdb_movie[:vote_average],
      m.backdrop_path = tmdb_movie[:backdrop_path],
      m.popularity = tmdb_movie[:popularity]
    end

    tmdb_movie[:genre_ids].each { |id| movie.genres << Genre.find(id) }

    movie
  end

  def self.add_many_to_database(tmdb_array)
    tmdb_array.each do |tmdb_movie|
      Movie.add_to_database(tmdb_movie)
    end
  end

end
