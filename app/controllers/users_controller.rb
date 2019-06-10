class UsersController < ApplicationController
  def show
    user = User.find_by(id: params[:id])

    if user
      render json: user
    else
      render json: { error: 'no such user' }
    end
  end

  def create
    user = User.find_by(first_name: params[:firstName])

    if user
      render json: { error: 'user already exists' }
    else
      render json: User.create(user)
    end
  end

  def signin
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      render json: { id: user.id }
    else
      render json: { error: 'login failed'}, status: 400
    end
  end

  def rate_movie
    user = User.find_by(id: params[:userId])
    movie = Movie.find_by(id: params[:movieId])
    rating = params[:rating]

    if user && movie
      movie_watch = MovieWatch.create_or_update(user.id, movie.id, rating)
      render json: movie_watch
    else
      render json: { error: "either user or movie not found" }
    end
  end

  def forget_movie
    movie_watch = MovieWatch.find_by(user_id: params[:userId], movie_id: params[:movieId])
    if movie_watch
      render json: movie_watch.destroy
    else
      render json: { error: "either user or movie not found" }
    end
  end

end
