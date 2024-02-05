class MoviesController < ApplicationController

   def show
      facade = MovieFacade.new
      @movie = facade.get_movie_by_id(params[:movie_id])
      @user = User.find(params[:user_id])

   end

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