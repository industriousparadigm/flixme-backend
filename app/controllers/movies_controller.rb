class MoviesController < ApplicationController

  def index
    movies = get_movies(params[:page])

    render json: movies
  end

  def show
    movie = Movie.find_by(id: params[:id])

    if movie
      render json: movie
    else
      get_movie(params[:id])
    end
  end

  def create
    movie = Movie.add_to_database(params[:movie])
  end

  def search
    search_url = "https://api.themoviedb.org/3/search/movie?api_key=#{Rails.application.secrets.tmdb_key}&language=en-US&include_adult=false&page=1"

    search_term = params['search']
    response = JSON.parse(RestClient.get("#{search_url}&query=#{search_term}"))

    if response['total_results'] > 0
      movies = response['results']
      render json: movies
      Movie.create_or_update_many(movies)
    else
      render json: { error: 'no matches found' }
    end
  end

  private

  def get_movies(starting_page = 1)
    # first movies_url is for popular movies and second for top rated. Only one can be uncommented
    movies_url = "https://api.themoviedb.org/3/discover/movie?api_key=#{Rails.application.secrets.tmdb_key}&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false"
    # movies_url = "https://api.themoviedb.org/3/movie/top_rated?api_key=#{Rails.application.secrets.tmdb_key}&language=en-US"
    response = JSON.parse(RestClient.get(movies_url + "&page=#{starting_page}"))
    Movie.create_or_update_many(response['results'])
  end

  def get_movie(movie_id)
    movie_url = "https://api.themoviedb.org/3/movie/#{movie_id}?api_key=#{Rails.application.secrets.tmdb_key}&language=en-US"
    response = JSON.parse(RestClient.get(movie_url))
    if response
      render json: response
    else
      render json: { error: 'nope'}
    end 
  end

end
