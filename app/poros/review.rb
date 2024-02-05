class Review
   attr_reader :author, :username, :content

   def initialize(data)
      @author = data[:author_details][:name]
      @username = data[:author_details][:username]
      @content = data[:content]
   end
end