class ChangeApplicationFormReviewedDefault < ActiveRecord::Migration[5.2]
  def change
    change_column_default(:application_forms, :description, '')
    change_column_default(:application_forms, :reviewed, false)
    change_column_default(:application_forms, :accepted, nil)
  end
end
