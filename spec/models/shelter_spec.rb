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
  end
end
