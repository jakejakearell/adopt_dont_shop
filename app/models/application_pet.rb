class ApplicationPet < ApplicationRecord
  belongs_to :application_form
  belongs_to :pet
end
