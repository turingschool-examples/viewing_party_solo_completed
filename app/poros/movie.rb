class Movie
   attr_reader :id, :title, :vote_average, :runtime, :runtime_in_minutes, :genres, :summary, :cast, :total_reviews_count, :reviews

   def initialize(data)
      @id = data[:id]
      @title = data[:title]
      @vote_average = data[:vote_average]
      @runtime = set_runtime(data[:runtime])
      @runtime_in_minutes = data[:runtime]
      @genres = set_genres(data[:genres])
      @summary = data[:overview]
      @cast = set_cast(data[:cast])
      @total_reviews_count = set_reviews_count(data[:reviews])
      @reviews = set_reviews(data[:reviews]) 

   end

   def set_genres(arr)
      if arr
         arr.map { |g| g[:name]}
      else 
         [""]
      end
   end

   def set_runtime(min)
      if min
         hours = min / 60
         rest = (min % 60).to_s.rjust(2, "0")
         "#{hours}:#{rest}"
      else
         0
      end
   end

   def set_cast(cast_data)
      if cast_data
         cast_data.map do |cast|
            Cast.new(cast)
         end
      else
         [""]
      end
   end

   def set_reviews_count(reviews_data)
      if reviews_data
         reviews_data.count
      else
         0
      end
   end

   def set_reviews(reviews_data)
      if reviews_data
         reviews_data.map do |review|
            Review.new(review)
         end
      else 
         [""]
      end
   end

end