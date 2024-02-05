require "rails_helper"

RSpec.describe "Movie Details Page", type: :feature do 
   ## USER STORY 3
   # As a user, 
   # When I visit a movie's detail page (`/users/:user_id/movies/:movie_id`) where :id is a valid user id,
   # I should see
   # - a button to Create a Viewing Party
   # - a button to return to the Discover Page

   # I should also see the following information about the movie:

   # - Movie Title
   # - Vote Average of the movie
   # - Runtime in hours & minutes
   # - Genre(s) associated to movie
   # - Summary description
   # - List the first 10 cast members (characters & actress/actors)
   # - Count of total reviews
   # - Each review's author and information

   describe "When I visit a movie's detail page (/users/:user_id/movies/:movie_id) I should see", :vcr do 
      before :each do 
         User.create!(name: "Chris S", email: "chris@turing.edu")
      end
      it "A button to create a Viewing Party" do
         visit "/users/#{User.first.id}/movies/11"
         expect(page).to have_button "Create a Viewing Party"
      end
      it "A button to return to the Discover Pages" do 
         visit "/users/#{User.first.id}/movies/11"
         expect(page).to have_link "Back to Discover"
      end

      it "I should see the movie title, vote average, runtime in hours & minutes, genres associated to that movie, summary description, the first 10 cast members, count of total reviews, and each review's author and information." do 
         visit "/users/#{User.first.id}/movies/11"
            save_and_open_page

         within "#movie_details" do 
            expect(page).to have_content "Title: Star Wars"
            expect(page).to have_content "Vote Average: 8.204"
            expect(page).to have_content "Runtime: "
            expect(page).to have_content "Genres: Adventure, Action, and Science Fiction"
            expect(page).to have_content "Summary: Princess Leia is captured and held hostage by the evil Imperial forces in their effort to take over the galactic Empire. Venturesome Luke Skywalker and dashing captain Han Solo team together with the loveable robot duo R2-D2 and C-3PO to rescue the beautiful princess and restore peace and justice in the Empire."
            expect(page).to have_content "Cast:\n"
            within "#movie_cast" do
               expect(page).to have_content "played by", count: 10
            end
            expect(page).to have_content "Total Reviews: 6"
            expect(page).to have_content "Reviews:"
         end   
      end   
   end
end