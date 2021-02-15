class ChangeApplicationFormAcceptedDefault < ActiveRecord::Migration[5.2]
  def change
    change_column_default(:application_forms, :accepted, false)
  end
end
