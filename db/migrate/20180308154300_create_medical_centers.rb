class CreateMedicalCenters < ActiveRecord::Migration[5.1]
  def change
    create_table :medical_centers do |t|
      t.string :name
      t.string :address
      t.string :kind
      t.string :main_phone
      t.string :phone
      t.string :email
      t.string :web

      t.timestamps
    end
  end
end
