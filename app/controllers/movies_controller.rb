class MoviesController < ApplicationController

   def results
      facade = MovieFacade.new
      if params[:query] == "top"
         # find top rated movies
         @movies = facade.top_rated_movies
      else
         # find movie by title
         @movies = facade.search_by_title(params[:movie_title])
      end

   end 

end