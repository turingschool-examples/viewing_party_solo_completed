class Movie
   attr_reader :id, :title, :vote_average, :runtime, :genres, :summary, :cast, :total_reviews_count, :reviews

   def initialize(data)
      @id = data[:id]
      @title = data[:title]
      @vote_average = data[:vote_average]
      @runtime = set_runtime(data[:runtime])
      @genres = set_genres(data[:genres])
      @summary = data[:overview]
      @cast = set_cast(data[:cast])
      @total_reviews_count = set_reviews_count(data[:reviews]) # use separate endpoint
      @reviews = set_reviews(data[:reviews]) #use separate endpoint

   end

   def set_genres(arr)
      arr.map { |g| g[:name]}
   end

   def set_runtime(min)
      hours = min / 60
      rest = (min % 60).to_s.rjust(2, "0")
      "#{hours}:#{rest}"
   end

   def set_cast(cast_data)
      cast_data.map do |cast|
         Cast.new(cast)
      end
   end

   def set_reviews_count(reviews_data)
      reviews_data.count
   end

   def set_reviews(reviews_data)
      reviews_data.map do |review|
         Review.new(review)
      end
   end

end