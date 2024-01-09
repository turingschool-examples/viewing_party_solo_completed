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


end