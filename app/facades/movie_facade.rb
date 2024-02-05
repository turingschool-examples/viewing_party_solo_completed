class MovieFacade
   def initialize
      @service = MovieService.new
   end

   def top_rated_movies
      response = @service.top_rated_movies

      data = JSON.parse(response.body, symbolize_names: true)[:results].take(20)

      data.map do |movie|
         Movie.new(movie)
      end
   end

   def search_by_title(title)
      response = @service.search_by_title(title)
      data = JSON.parse(response.body, symbolize_names: true)[:results]
      data.map do |movie|
         Movie.new(movie)
      end
   end
   
   def get_movie_by_id(movie_id)
      # movie details
      response = @service.get_movie_by_id(movie_id)
      data = JSON.parse(response.body, symbolize_names: true)

      # cast
      cast_data = @service.get_cast_by_movie_id(movie_id)
      cast = JSON.parse(cast_data.body, symbolize_names: true)
      data[:cast] = cast[:cast].take(10)

      # reviews
      reviews_data = @service.get_reviews_by_movie_id(movie_id)
      reviews = JSON.parse(reviews_data.body, symbolize_names: true)
      data[:reviews] = reviews[:results]

      Movie.new(data)
   end


end