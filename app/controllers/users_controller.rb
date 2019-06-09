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
    # puts "#{User.find_by(id: params[:userId]).firstName} has rated #{Movie.find_by(id: params[:movieId]).title} with #{params[:rating]} stars out of 5."
    user = User.find_by(id: params[:userId])
    movie = Movie.find_by(id: params[:movieId])
    rating = params[:rating]

    if user && movie
      MovieWatch.create_or_update(user.id, movie.id, rating)
    else
      puts "either user or movie id invalid"
    end
  end
end
