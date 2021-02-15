require 'rails_helper'

RSpec.describe "the Application index page", type: :feature do
  before :each do
    @lhs = Shelter.create!(name: 'Longmont Humane Society', address: '9595 Nelson Road', city: 'Longmont', state: 'CO', zip: 80501)
    @dfl = Shelter.create!(name: 'Dumb Friends League', address: '191 Yuma Street', city: 'Denver', state: 'CO', zip: 80223)

    @gracie = @lhs.pets.create!(image: "IMG_0337.JPG", name: "gracie", approximate_age: 8, description: "puppy", sex: 1)
    @jack = @lhs.pets.create!(image: "IMG_0337.JPG", name: "jack", approximate_age: 10, description: "old", sex: 1)
    @cindy = @lhs.pets.create!(image: "IMG_0337.JPG", name: "cindy", approximate_age: 2, description: "young", sex: 1)

    @chippy = @dfl.pets.create!(image: "IMG_0337.JPG", name: "chippy", approximate_age: 1, description: "dumb", sex: 1)
    @choppy = @dfl.pets.create!(image: "IMG_0337.JPG", name: "choppy", approximate_age: 12, description: "thich", sex: 1)
    @floppy = @dfl.pets.create!(image: "IMG_0337.JPG", name: "floppie", approximate_age: 7, description: "chiller", sex: 1)

    @app_1 = ApplicationForm.create!(name:"jake",
                                     street_address:"123 st",
                                     city:"Mead",
                                     state:"CO",
                                     zip_code:80235,
                                     description:"i want puppy"
                                      )

    @app_2 = ApplicationForm.create!(name:"seth",
                                     street_address:"124 st",
                                     city:"Longmont",
                                     state:"CO",
                                     zip_code:80501,
                                     description:"i want old dog",
                                      )

    @app_3 = ApplicationForm.create!(name:"chad",
                                     street_address:"234 lane",
                                     city:"boulder",
                                     state:"CO",
                                     zip_code:80501,
                                     description:"i want cool dog"
                                      )

    ApplicationPet.create!(application_form: @app_1, pet: @chippy)
    ApplicationPet.create!(application_form: @app_1, pet: @gracie)
    ApplicationPet.create!(application_form: @app_1, pet: @floppy)

  end

  describe "As a visitor" do
    describe 'when I visit a show page' do
      it "should display all the application info" do
        visit "/applications/#{@app_1.id}"

        expect(page).to have_content(@app_1.name)
        expect(page).to have_content(@app_1.street_address)
        expect(page).to have_content(@app_1.city)
        expect(page).to have_content(@app_1.state)
        expect(page).to have_content(@app_1.description)
        expect(page).to have_content("#{@app_1.zip_code}")
        expect(page).to have_content("Status: In Progress")

        within("#pet-#{@chippy.id}") do
          expect(page).to have_link "#{@chippy.name}", href: "/pets/#{@chippy.id}"
        end

        within("#pet-#{@gracie.id}") do
          expect(page).to have_link "#{@gracie.name}", href: "/pets/#{@gracie.id}"
        end

        within("#pet-#{@floppy.id}") do
          expect(page).to have_link "#{@floppy.name}", href: "/pets/#{@floppy.id}"
        end
      end

      describe 'I can search for pets' do
        it "can add them to my application" do
          visit "/applications/#{@app_3.id}"

          expect(page).to have_button('Search for pets')

          fill_in 'query', with: "jack"

          click_on 'Search for pets'

          click_on 'Adopt Me'

          expect(page).to have_content("jack")

          expect(current_path).to eq("/applications/#{@app_3.id}")
        end

        it "will only allow me to add a description and submit my application when I have added a pet" do
          visit "/applications/#{@app_3.id}"

          expect(page).to have_no_content "why I want pets"

          fill_in 'query', with: "jack"
          click_on 'Search for pets'
          click_on 'Adopt Me'


          expect(page).to have_content "why I want pets"
          fill_in 'description', with: "I love dogs!"

          within("#application-#{@app_3.id}") do
            click_button
          end

          expect(page).to have_content "Description: I love dogs!"
        end

        it "will only allow to search for pets when my application is 'in progress' " do
          visit "/applications/#{@app_3.id}"

          expect(page).to have_no_content "why I want pets"

          fill_in 'query', with: "jack"
          click_on 'Search for pets'
          click_on 'Adopt Me'


          expect(page).to have_content "why I want pets"
          fill_in 'description', with: "I love dogs!"

          within("#application-#{@app_3.id}") do
            click_button
          end

          expect(page).to have_content "Pending"

          expect(page).to have_no_button "Search for pets"
        end
      end
    end
  end
end
