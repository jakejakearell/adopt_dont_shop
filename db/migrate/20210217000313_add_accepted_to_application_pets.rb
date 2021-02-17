class AddAcceptedToApplicationPets < ActiveRecord::Migration[5.2]
  def change
    add_column :application_pets, :accepted, :boolean
  end
end
