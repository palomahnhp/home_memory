class CreatePrescriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :prescriptions do |t|
      t.belongs_to :appointmemt
      t.belongs_to :medication
      t.belongs_to :posology

      t.timestamps
    end
  end
end
