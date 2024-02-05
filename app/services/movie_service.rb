class MovieService

   def conn
      Faraday.new("https://api.themoviedb.org/3/") do |f|
         f.params[:api_key] = Rails.application.credentials.tmdb[:key]
      end
   end
      
   def get_url(url)
      conn.get(url)
   end

   def top_rated_movies
      get_url("movie/top_rated")
   end

   def search_by_title(title)
      get_url("search/movie?query=#{title}")
   end

   def get_movie_by_id(id)
      get_url("movie/#{id}")
   end

   def get_cast_by_movie_id(movie_id)
      get_url("movie/#{movie_id}/credits")
   end

   def get_reviews_by_movie_id(movie_id)
      get_url("movie/#{movie_id}/reviews")
   end


end