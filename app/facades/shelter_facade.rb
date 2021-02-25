class ShelterFacade
  def initialize(shelter_id)
    @shelter_id = shelter_id
  end

  def name
    shelter.name
  end

  def address
    shelter.address
  end

  def city
    shelter.city
  end

  def state
    shelter.state
  end

  def zip
    shelter.zip
  end

  def count
    Shelter.adoptable_pets(@shelter_id)
  end

  def adopted
    Shelter.adopted_pets(@shelter_id)
  end

  def age
    Shelter.pet_age(@shelter_id)
  end

  def action_required
    Shelter.action_required(@shelter_id)
  end

  private


  def shelter
    @shelter ||= Shelter.find(@shelter_id)
  end
end
