class MoviesController < ApplicationController

  search_url = "https://api.themoviedb.org/3/search/movie?api_key=#{Rails.application.secrets.tmdb_key}&language=en-US&page=1"
#&query=

  def index
    params['limit'] ? limit = params['limit'].to_i : limit = 20
    offset = params['offset'].to_i
    movies = Movie.limit(limit).offset(offset)

    render json: movies
  end

  def show
    movie = Movie.find_by(id: params[:id])

    if movie
      render json: movie
    else
      render json: { error: 'movie not found' }
    end
  end

  def create
    movie = Movie.add_to_database(params[:movie])
  end

  def search
    search_term = params['search']
    response = JSON.parse(RestClient.get(search_url + "&query=#{search_term}"))

    if response['total_results'] > 0
      movies = response['results']
      render json: movies
      Movie.add_many_to_database(movies)
    else
      render json: { error: 'no matches found' }
    end
  end

end
