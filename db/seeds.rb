genres_url = "https://api.themoviedb.org/3/genre/movie/list?api_key=#{Rails.application.secrets.tmdb_key}&language=en-US"
movies_url = "https://api.themoviedb.org/3/discover/movie?api_key=#{Rails.application.secrets.tmdb_key}&language=en-US&sort_by=popularity.desc&include_video=false"


# &page=

# fetch the genres
response = JSON.parse(RestClient.get(genres_url))
response['genres'].each do |genre|
  Genre.find_or_create_by(genre)
end

# fetch a shitload of movies. Let's say 1000 pages worth of movies. 40 requests 25 times @ 11s each = 275s or ~5min
page = 1
25.times do
  40.times do
    response = JSON.parse(RestClient.get(movies_url + "&page=#{page}"))

    response["results"].each do |movie_json|
      movie = Movie.find_or_create_by(id: movie_json["id"]) do |m|
        m.adult = movie_json["adult"],
        m.title = movie_json["title"],
        m.poster_path = movie_json["poster_path"],
        m.overview = movie_json["overview"],
        m.release_date = movie_json["release_date"],
        m.original_language = movie_json["original_language"],
        m.vote_count = movie_json["vote_count"],
        m.vote_average = movie_json["vote_average"],
        m.backdrop_path = movie_json["backdrop_path"],
        m.popularity = movie_json["popularity"]
      end

      movie_json['genre_ids'].each { |id| movie.genres << Genre.find(id) }
    end

    page += 1
  end
  sleep 11
end