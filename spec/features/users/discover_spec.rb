require "rails_helper"

RSpec.describe "User Movies DIscover page", type: :feature do 

# As a user,
# When I visit the '/users/:id/discover' path (where :id is the id of a valid user),
# I should see
# - a Button to Discover Top Rated Movies
# - a text field to enter keyword(s) to search by movie title
# - a Button to Search by Movie Title
# Notes:

# When the user clicks on the Top Rated Movies OR the search button, they should be taken to the movies results page (more details of this on the 2. Movies Results Page story).

   # US 1
   describe "When I visit the discover path" do 
      before :each do 
         User.create!(name: "Chris S", email: "chris@turing.edu")
         visit "/users/#{User.first.id}/discover"
      end
      it "I should see a button to discover Top Rated Movies" do
         expect(page).to have_button "Discover Top Rated Movies"
      end

      it "I see a text field to enter keywords to search by movie title" do
         expect(page).to have_field "movie_title"
      end

      it "I see a button to search by movie title" do
         expect(page).to have_button "Search by Movie Title"
      end

   end

   # US2

#    When I visit the discover movies page ('/users/:id/discover'),
# and click on either the Discover Top Rated Movies button or fill out the movie title search and click the Search button,
# I should be taken to the movies results page (`users/:user_id/movies`) where I see: 

# - Title (As a Link to the Movie Details page (see story #3))
# - Vote Average of the movie

# I should also see a button to return to the Discover Page.
# Notes:

# There should only be a maximum of 20 results. The above details should be listed for each movie.


   describe "When I visit the discover movies page '/users/:id/discover'" do
      before :each do 
         User.create!(name: "Chris S", email: "chris@turing.edu")
         visit "/users/#{User.first.id}/discover"
      end

      it "When I click on either buttons, I should be taken to the results page where i see Titles and Vote Average of the movie(s)" do
         json_top = File.read("spec/fixtures/top_movies.json")
         stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?api_key=#{Rails.application.credentials.tmdb[:key]}").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.8.1'
           }).
         to_return(status: 200, body: json_top, headers: {})

         click_button "Discover Top Rated Movies"
         expect(current_path).to eq("/users/#{User.first.id}/movies")
         expect(page).to have_content("The Shawshank Redemption: 8.71")

         visit "/users/#{User.first.id}/discover"
         fill_in :movie_title, with: "Star Wars: A New Hope"

         json_single = File.read("spec/fixtures/star_wars.json")
         stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=#{Rails.application.credentials.tmdb[:key]}&query=Star%20Wars:%20A%20New%20Hope").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.8.1'
           }).
         to_return(status: 200, body: json_single, headers: {})

         click_button "Search by Movie Title"
         expect(current_path).to eq("/users/#{User.first.id}/movies")
         expect(page).to have_content("Star Wars")
         #title
         #average

      end

      it "I should see a button to return to the discover page" do 
         json_single = File.read("spec/fixtures/star_wars.json")
         stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=#{Rails.application.credentials.tmdb[:key]}&query=Star%20Wars:%20A%20New%20Hope").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.8.1'
           }).
         to_return(status: 200, body: json_single, headers: {})

         fill_in :movie_title, with: "Star Wars: A New Hope"
         click_button "Search by Movie Title"

         expect(page).to have_button "Return to Discover Page"

         click_button "Return to Discover Page"
         expect(current_path).to eq("/users/#{User.first.id}/discover")
      end

   end



end