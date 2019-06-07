class MoviesController < ApplicationController

  def index
    params['limit'] ? limit = params['limit'].to_i : limit = 20
    offset = params['offset'].to_i
    movies = Movie.limit(limit).offset(offset)
    # genres_url = "https://api.themoviedb.org/3/genre/movie/list?api_key=#{Rails.application.secrets.tmdb_key}&language=en-US"
    # movies_url = "https://api.themoviedb.org/3/discover/movie?api_key=#{Rails.application.secrets.tmdb_key}&language=en-US&sort_by=popularity.desc&include_video=false&page=1"

    # movies = JSON.parse(RestClient.get(movies_url))

    # # go through these movies and add them to the database if not already there
    # movies["results"].each do |movie|
    #   m = Movie.find_or_create_by(
    #     id: movie["id"],
    #     poster_path: movie["poster_path"],
    #     adult: movie["adult"],
    #     overview: movie["overview"],
    #     release_date: movie["release_date"],
    #     title: movie["title"],
    #     original_language: movie["original_language"],
    #     vote_count: movie["vote_count"],
    #     vote_average: movie["vote_average"],
    #     backdrop_path: movie["backdrop_path"],
    #     popularity: movie["popularity"]
    #   )
    # end

    render json: movies
  end

  def show
    # render json: { key: Rails.application.secrets.tmdb_key }
  end

  def more_movies

  end

end
