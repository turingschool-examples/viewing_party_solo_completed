require "rails_helper"

RSpec.describe "New Viewing Party Page", type: :feature do 
   # #User Story 4
#    When I visit the new viewing party page ('/users/:user_id/movies/:movie_id/viewing_party/new', where :user_id is a valid user's id and :movie_id is a valid Movie id from the API),
# I should see the name of the movie title rendered above a form with the following fields:

# - Duration of Party with a default value of movie runtime in minutes; a viewing party should NOT be created if set to a value less than the duration of the movie
# - When: field to select date
# - Start Time: field to select time
# - Checkboxes next to each existing user in the system
# - Button to create a party

   describe "When I visit hte new viewing party page", :vcr do 
      before :each do 
         User.create!(name: "Chris S", email: "chris@turing.edu")
      end
      it "I should see the name of the movie title rendered above a form with fields for duration of party, when, start time, button to create a party" do 
         visit "/users/#{User.first.id}/movies/11/viewing_party/new"
         expect(page).to have_content("New Viewing Party")
         expect(page).to have_content("Star Wars")
         expect(page).to have_field :duration
         expect(page).to have_field :when
         expect(page).to have_field :start_time
         expect(page).to have_button "Create Party"
      end

      it "As well as checkboxes next to each existing user in the system." do 
         5.times do 
            User.create!(name: Faker::Name.name, email: Faker::Internet.email)
         end
         visit "/users/#{User.first.id}/movies/11/viewing_party/new"
         expect(page).to have_field "invited_users[]", count: 5
      end

      it "Can create the new party, and successfully redirects to the user's dashboard, where I see my new Viewing Party listed" do 
         5.times do 
            User.create!(name: Faker::Name.name, email: Faker::Internet.email)
         end
         visit "/users/#{User.first.id}/movies/11/viewing_party/new"
         fill_in :when, with: "2024-02-15"
         fill_in :start_time, with: "13:30"
         check "invited_users_#{User.last.id}"
         check "invited_users_#{User.second.id}"

         click_button "Create Party"

         expect(current_path).to eq "/users/#{User.first.id}"
         save_and_open_page
         expect(page).to have_content "Movie"

      end
   end

end