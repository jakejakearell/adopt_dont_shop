require 'rails_helper'

RSpec.describe ApplicationPet, type: :model do
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

    ApplicationPet.create!(application_form: @app_2, pet: @jack)

  end

  describe "relationship" do
    it {should belong_to :pet}
    it {should belong_to :application_form}
  end

  describe "class methods" do
    it "#pets_on_application" do
      expect(ApplicationPet.pets_on_application(@app_1.id).count).to eq(3)

    end

    it "#pet_on_app" do
      expect(ApplicationPet.pet_on_app(@gracie.id, @app_1.id).count).to eq(1)
      expect(ApplicationPet.pet_on_app(@gracie.id, @app_1.id)[0].pet_id).to eq(@gracie.id)

    end

    it "#approved?" do
      pet_1 = ApplicationPet.pet_on_app(@gracie.id, @app_1.id)
      pet_2 = ApplicationPet.pet_on_app(@chippy.id, @app_1.id)
      pet_3 = ApplicationPet.pet_on_app(@floppy.id, @app_1.id)

      pet_1.update(accepted: true)
      pet_2.update(accepted: true)
      pet_3.update(accepted: true)
      @app_1.update(reviewed: true)

      ApplicationPet.approved?(@gracie.id, @app_1.id)
      ApplicationPet.approved?(@chippy.id, @app_1.id)
      ApplicationPet.approved?(@floppy.id, @app_1.id)

      expect(ApplicationPet.pets_on_application(@app_1.id).where("accepted = ?", true).count).to eq(ApplicationPet.pets_on_application(@app_1.id).count)

      pet_4 = ApplicationPet.pet_on_app(@jack.id, @app_2.id)
      pet_4.update(accepted: false)
      @app_1.update(reviewed: true)

      ApplicationPet.approved?(@jack.id, @app_2.id)

      expect(ApplicationPet.pets_on_application(@app_2.id).where("accepted = ?", false).count).to eq(ApplicationPet.pets_on_application(@app_2.id).count)

    end
  end
end
