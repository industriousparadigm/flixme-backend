class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :movies_watched

  def name
    "#{object.firstName} #{object.lastName}"
  end

  def movies_watched
    object.movies.map do |movie|
      movie_watch = MovieWatch.find_by(user: object, movie: movie)
      {
        movie_id: movie.id,
        rating: movie_watch.rating
      }
    end
  end
end
