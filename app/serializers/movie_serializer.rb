class MovieSerializer < ActiveModel::Serializer
  attributes :id, :title, :release_date, :overview, :genres, :popularity, :poster_path

  def genres
    object.genres.map(&:name)
  end
end
