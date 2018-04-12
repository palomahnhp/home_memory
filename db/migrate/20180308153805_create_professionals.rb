class CreateProfessionals < ActiveRecord::Migration[5.1]
  def change
    create_table :professionals do |t|
      t.string :firstname
      t.string :surname
      t.belongs_to :speciality
      t.belongs_to :medical_center
      t.text :comments

      t.timestamps
    end
  end
end
