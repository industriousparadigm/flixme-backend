class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :first_name, :last_name, :email, :avatar_url, :friends, :movies_watched
  # has_many :friends

  def name
    "#{object.first_name} #{object.last_name}"
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