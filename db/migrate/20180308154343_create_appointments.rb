class CreateAppointments < ActiveRecord::Migration[5.1]
  def change
    create_table :appointments do |t|
      t.belongs_to :patient, index: true, foreign_key: true
      t.belongs_to :professional, index: true, foreign_key: true
      t.text       :reason
      t.datetime   :appointment_time
      t.belongs_to :medical_center, index: true, foreign_key: true
      t.string     :location

      t.string     :update_by

      t.timestamps
      t.timestamps
    end
  end

end
