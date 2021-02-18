require 'rails_helper'

RSpec.describe ApplicationPet, type: :model do

  describe "relationship" do
    it {should belong_to :pet}
    it {should belong_to :application_form}
  end

  describe "class methods" do
    it "#pets_on_application" do

      dfl = Shelter.create!(name: 'Dumb Friends League', address: '191 Yuma Street', city: 'Denver', state: 'CO', zip: 80223)

      chippy = dfl.pets.create!(image: "IMG_0337.JPG", name: "chippy", approximate_age: 1, description: "dumb", sex: 1)

      app_1 = ApplicationForm.create!(name:"jake",
                                       street_address:"123 st",
                                       city:"Mead",
                                       state:"CO",
                                       zip_code:80235,
                                       description:"i want puppy"
                                        )


      ApplicationPet.create!(application_form: app_1, pet: chippy)

      expected = [chippy]

      expect(ApplicationPet.pets_on_application(app_1.id)[0].pet_id).to eq(chippy.id)
    end
  end
end
