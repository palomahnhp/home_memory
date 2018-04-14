class CreatePrescriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :prescriptions do |t|
      t.belongs_to :appointments, index: true, foreign_key: true
      t.belongs_to :medication, index: true, foreign_key: true
      t.string     :posology, index: true, foreign_key: true
      t.date :init_at
      t.date :end_at

      t.timestamps
    end
  end
end
