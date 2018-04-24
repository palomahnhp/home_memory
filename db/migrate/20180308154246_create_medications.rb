class CreateMedications < ActiveRecord::Migration[5.1]
  def change
    create_table :medications do |t|
      t.string :name
      t.string :active_ingredient
      t.string :presentation
      t.string :laboratory
      t.attachment :prospect

      t.timestamps
    end
  end
end
