require 'rails_helper'

RSpec.describe "the Application index page", type: :model do
  before :each do
    @lhs = Shelter.create!(name: 'Zippy Humane Society', address: '9595 Nelson Road', city: 'Longmont', state: 'CO', zip: 80501)
    @dfl = Shelter.create!(name: 'Dumb Friends League', address: '191 Yuma Street', city: 'Denver', state: 'CO', zip: 80223)

  end

  describe 'it exists' do
    it "has methods" do
      shelter_facade = ShelterFacade.new(@lhs.id)
      expect(shelter_facade.name).to eq(@lhs.name)
      expect(shelter_facade.address).to eq(@lhs.address)
      expect(shelter_facade.city).to eq(@lhs.city)
      expect(shelter_facade.state).to eq(@lhs.state)
      expect(shelter_facade.zip).to eq(@lhs.zip)
      expect(shelter_facade.count).to eq(Shelter.adoptable_pets(@lhs.id))
      expect(shelter_facade.adopted).to eq(Shelter.adopted_pets(@lhs.id))
      expect(shelter_facade.age).to eq(Shelter.pet_age(@lhs.id))
      expect(shelter_facade.action_required).to eq(Shelter.action_required(@lhs.id))
    end

    it "has methods" do
      shelter_facade = ShelterFacade.new(@dfl.id)
      expect(shelter_facade.name).to eq(@dfl.name)
      expect(shelter_facade.address).to eq(@dfl.address)
      expect(shelter_facade.city).to eq(@dfl.city)
      expect(shelter_facade.state).to eq(@dfl.state)
      expect(shelter_facade.zip).to eq(@dfl.zip)
      expect(shelter_facade.count).to eq(Shelter.adoptable_pets(@dfl.id))
      expect(shelter_facade.adopted).to eq(Shelter.adopted_pets(@dfl.id))
      expect(shelter_facade.age).to eq(Shelter.pet_age(@dfl.id))
      expect(shelter_facade.action_required).to eq(Shelter.action_required(@dfl.id))
    end
  end
end
