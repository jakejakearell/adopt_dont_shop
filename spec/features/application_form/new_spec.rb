require 'rails_helper'

RSpec.describe "the Application index page", type: :feature do
  before :each do
    @lhs = Shelter.create!(name: 'Longmont Humane Society', address: '9595 Nelson Road', city: 'Longmont', state: 'CO', zip: 80501)
    @dfl = Shelter.create!(name: 'Dumb Friends League', address: '191 Yuma Street', city: 'Denver', state: 'CO', zip: 80223)

    @gracie = @lhs.pets.create!(image: "nothing", name: "gracie", approximate_age: 8, description: "puppy", sex: 1)
    @jack = @lhs.pets.create!(image: "nothing", name: "jack", approximate_age: 10, description: "old", sex: 1)
    @cindy = @lhs.pets.create!(image: "nothing", name: "cindy", approximate_age: 2, description: "young", sex: 1)

    @chippy = @dfl.pets.create!(image: "nothing", name: "chippy", approximate_age: 1, description: "dumb", sex: 1)
    @choppy = @dfl.pets.create!(image: "nothing", name: "choppy", approximate_age: 12, description: "thich", sex: 1)
    @floppy = @dfl.pets.create!(image: "nothing", name: "floppie", approximate_age: 7, description: "chiller", sex: 1)

    @app_1 = ApplicationForm.create!(name:"jake",
                                     street_address:"123 st",
                                     city:"Mead",
                                     state:"CO",
                                     zip_code:80235,
                                     description:"i want puppy",
                                     reviewed: true,
                                     accepted: true)

    @app_2 = ApplicationForm.create!(name:"seth",
                                     street_address:"124 st",
                                     city:"Longmont",
                                     state:"CO",
                                     zip_code:80501,
                                     description:"i want old dog",
                                     reviewed: true,
                                     accepted: true)

    ApplicationPet.create!(application_form: @app_1, pet: @chippy)
    ApplicationPet.create!(application_form: @app_1, pet: @gracie)
    ApplicationPet.create!(application_form: @app_1, pet: @floppy)

    ApplicationPet.create!(application_form: @app_2, pet: @choppy)
    ApplicationPet.create!(application_form: @app_2, pet: @jack)
    ApplicationPet.create!(application_form: @app_2, pet: @cindy)
  end

  describe 'As a visitor' do
    describe "When I visit the new application link on the pets index page" do
      it "should have a form to create a new application" do
        visit '/applications/new'


        fill_in "name", with: "jeff"
        fill_in "street_address", with: '123 st'
        fill_in "city", with: 'Dover'
        fill_in "state", with: 'CO'
        fill_in "zip_code", with: 3
        fill_in "description", with: "idk"
        fill_in "reviewed", with: "false"
        fill_in "accepted", with: "false"

        click_on 'Create Application'

        expect(current_path).to eq("/applications/#{ApplicationForm.last.id}")

        expect(page).to have_content("In Progress")
        expect(page).to have_content("jeff")
        expect(page).to have_content("123 st")
        expect(page).to have_content("Dover")
        expect(page).to have_content("3")
      end

      it "cannot create an application without filling out all forms" do
        visit '/applications/new'

        click_on 'Create Application'

        expect(page).to have_content("Application not created: Required information missing.")
        expect(page).to have_button('Create Application')
      end
    end
  end
end
