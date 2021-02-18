class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :application_pets
  has_many :application_forms, through: :application_pets
  validates_presence_of :name, :description, :approximate_age, :sex

  validates :approximate_age, numericality: {
              greater_than_or_equal_to: 0
            }

  enum sex: [:female, :male]

  def self.search(pet_name)
   where("name ilike ? AND adoptable = true", "%#{pet_name}%")
 end
end
