class Shelter < ApplicationRecord
  has_many :pets

  def self.reverse_order_by_name
    Shelter.find_by_sql("SELECT shelters.* FROM shelters ORDER BY shelters.name DESC")
  end

  def self.pending_apps
    Pet.joins(:shelter).joins(:application_forms).where('application_forms.accepted is NULL AND reviewed = ? ', true).select("shelters.name").order("shelters.name ASC").distinct
  end

  def self.adoptable_pets(id)
    Shelter.joins(:pets).where("adoptable = ?", true).where("shelters.id = ?", id).count
  end

  def self.adopted_pets(id)
    Shelter.joins(:pets).where("adoptable = ?", false).where("shelters.id = ?", id).count
  end

  def self.pet_age(id)
    Pet.select("pets.approximate_age, shelter_id").joins(:shelter).where("shelters.id = ?", id).average("approximate_age")
  end

  def self.action_required(id)
    Pet.joins(:shelter).joins(:application_forms).where('application_forms.accepted is NULL AND reviewed = ? ', true).where("shelters.id = ?", id)
  end
end
