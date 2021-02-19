require 'rails_helper'

describe Shelter, type: :model do
  describe 'relationships' do
    it { should have_many :pets }
  end

  describe 'class methods' do
    it "#reverse_order_by_name" do
      lhs = Shelter.create!(name: 'Zippy Humane Society', address: '9595 Nelson Road', city: 'Longmont', state: 'CO', zip: 80501)
      dfl = Shelter.create!(name: 'Arbies Friends League', address: '191 Yuma Street', city: 'Denver', state: 'CO', zip: 80223)
      dfl = Shelter.create!(name: 'Dumb Friends League', address: '191 Yuma Street', city: 'Denver', state: 'CO', zip: 80223)

      shelters = Shelter.reverse_order_by_name

      expect(Shelter.reverse_order_by_name.first.name).to eq("Zippy Humane Society")
      expect(Shelter.reverse_order_by_name.last.name).to eq("Arbies Friends League")

    end

    it "#pending_apps" do
      lhs = Shelter.create!(name: 'Zippy Humane Society', address: '9595 Nelson Road', city: 'Longmont', state: 'CO', zip: 80501)
      dfl = Shelter.create!(name: 'Arbies Friends League', address: '191 Yuma Street', city: 'Denver', state: 'CO', zip: 80223)
      dfl = Shelter.create!(name: 'Dumb Friends League', address: '191 Yuma Street', city: 'Denver', state: 'CO', zip: 80223)

      expect(Shelter.pending_apps[0]).to eq(nil)

    end

    it "#adoptable_pets" do
      lhs = Shelter.create!(name: 'Zippy Humane Society', address: '9595 Nelson Road', city: 'Longmont', state: 'CO', zip: 80501)
      dfl = Shelter.create!(name: 'Arbies Friends League', address: '191 Yuma Street', city: 'Denver', state: 'CO', zip: 80223)
      dfl = Shelter.create!(name: 'Dumb Friends League', address: '191 Yuma Street', city: 'Denver', state: 'CO', zip: 80223)

      expect(Shelter.adopted_pets(lhs.id)).to eq(0)

    end

    it "#adopted_pets" do
      lhs = Shelter.create!(name: 'Zippy Humane Society', address: '9595 Nelson Road', city: 'Longmont', state: 'CO', zip: 80501)
      dfl = Shelter.create!(name: 'Arbies Friends League', address: '191 Yuma Street', city: 'Denver', state: 'CO', zip: 80223)
      dfl = Shelter.create!(name: 'Dumb Friends League', address: '191 Yuma Street', city: 'Denver', state: 'CO', zip: 80223)

      expect(Shelter.adoptable_pets(lhs.id)).to eq(0)

    end

    it "#pet_age" do
      lhs = Shelter.create!(name: 'Zippy Humane Society', address: '9595 Nelson Road', city: 'Longmont', state: 'CO', zip: 80501)
      dfl = Shelter.create!(name: 'Arbies Friends League', address: '191 Yuma Street', city: 'Denver', state: 'CO', zip: 80223)
      dfl = Shelter.create!(name: 'Dumb Friends League', address: '191 Yuma Street', city: 'Denver', state: 'CO', zip: 80223)

      chippy = dfl.pets.create!(image: "IMG_0337.JPG", name: "chippy", approximate_age: 1, description: "dumb", sex: 1)
      choppy = dfl.pets.create!(image: "IMG_0337.JPG", name: "choppy", approximate_age: 12, description: "thich", sex: 1)

      expect(Shelter.pet_age(dfl.id)).to eq(0.65e1)

    end

    it "#action_required" do
      lhs = Shelter.create!(name: 'Zippy Humane Society', address: '9595 Nelson Road', city: 'Longmont', state: 'CO', zip: 80501)
      dfl = Shelter.create!(name: 'Arbies Friends League', address: '191 Yuma Street', city: 'Denver', state: 'CO', zip: 80223)
      dfl = Shelter.create!(name: 'Dumb Friends League', address: '191 Yuma Street', city: 'Denver', state: 'CO', zip: 80223)

      chippy = dfl.pets.create!(image: "IMG_0337.JPG", name: "chippy", approximate_age: 1, description: "dumb", sex: 1)
      choppy = dfl.pets.create!(image: "IMG_0337.JPG", name: "choppy", approximate_age: 12, description: "thich", sex: 1)

      expect(Shelter.action_required(lhs.id)[0]).to eq(nil)

    end
  end
end
