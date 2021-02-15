ApplicationPet.destroy_all
Pet.destroy_all
Shelter.destroy_all
ApplicationForm.destroy_all

lhs = Shelter.create!(name: 'Longmont Humane Society', address: '9595 Nelson Road', city: 'Longmont', state: 'CO', zip: 80501)
dfl = Shelter.create!(name: 'Dumb Friends League', address: '191 Yuma Street', city: 'Denver', state: 'CO', zip: 80223)

gracie = lhs.pets.create!(image: "IMG_0337.JPG", name: "gracie", approximate_age: 8, description: "puppy", sex: 1)
jack = lhs.pets.create!(image: "IMG_0337.JPG", name: "jack", approximate_age: 10, description: "old", sex: 1)
cindy = lhs.pets.create!(image: "IMG_0337.JPG", name: "cindy", approximate_age: 2, description: "young", sex: 1)

chippy = dfl.pets.create!(image: "IMG_0337.JPG", name: "chippy", approximate_age: 1, description: "dumb", sex: 1)
choppy = dfl.pets.create!(image: "IMG_0337.JPG", name: "choppy", approximate_age: 12, description: "thich", sex: 1)
floppy = dfl.pets.create!(image: "IMG_0337.JPG", name: "floppie", approximate_age: 7, description: "chiller", sex: 1)

app_1 = ApplicationForm.create!(name:"jake",
                                 street_address:"123 st",
                                 city:"Mead",
                                 state:"CO",
                                 zip_code:80235,
                                 description:"i want puppy"
                                )

app_2 = ApplicationForm.create!(name:"seth",
                                 street_address:"124 st",
                                 city:"Longmont",
                                 state:"CO",
                                 zip_code:80501,
                                 description:"i want old dog"
                               )

ApplicationPet.create!(application_form: app_1, pet: chippy)
ApplicationPet.create!(application_form: app_1, pet: gracie)
ApplicationPet.create!(application_form: app_1, pet: floppy)

ApplicationPet.create!(application_form: app_2, pet: choppy)
ApplicationPet.create!(application_form: app_2, pet: jack)
ApplicationPet.create!(application_form: app_2, pet: cindy)
