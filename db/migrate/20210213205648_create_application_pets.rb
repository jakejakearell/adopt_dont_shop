class CreateApplicationPets < ActiveRecord::Migration[5.2]
  def change
    create_table :application_pets do |t|
      t.references :pet, foreign_key: true
      t.references :application_form, foreign_key: true
    end
  end
end
