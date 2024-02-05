class Cast
   attr_reader :id, :character, :actor
   def initialize(data)
      @id = data[:id]
      @character = data[:character]
      @actor = data[:name]
   end

end