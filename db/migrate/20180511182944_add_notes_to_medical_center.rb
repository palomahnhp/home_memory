class AddNotesToMedicalCenter < ActiveRecord::Migration[5.1]
  def change
    add_column :medical_centers, :notes, :text
  end
end
