class UsersController < ApplicationController
  def show
    user = User.find_by(id: params[:id])

    if user
      render json: user
    else
      render json: { error: 'no such user' }
    end
  end

  def rate_movie
    user = User.find_by(id: params[:userId])
    movie = Movie.find_by(id: params[:movieId])
    rating = params[:rating]

    if user && movie
      MovieWatch.create_or_update(user.id, movie.id, rating)
      render json: user
    else
      render json: { error: "either user or movie not found" }
    end
  end
end
