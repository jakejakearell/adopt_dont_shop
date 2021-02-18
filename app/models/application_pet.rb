class ApplicationPet < ApplicationRecord
  belongs_to :application_form
  belongs_to :pet

  def self.pets_on_application(application_id)
    where("application_form_id = ?", application_id)
  end

  def self.pet_on_app(pet_id, app_id)
    where("pet_id = ? AND application_form_id = ?", pet_id, app_id)
  end

  def self.approved?(pet_id, app_id)
    application = ApplicationForm.find(app_id)
    pets = ApplicationPet.where("pet_id = ? AND application_form_id = ?", pet_id, app_id)

    if pets.where("accepted = ?", false).count >= 1
      application.update(accepted: false)
    elsif pets.where("accepted = ?", true).count == pets.count
      application.update(accepted: true)
    end
  end
end
