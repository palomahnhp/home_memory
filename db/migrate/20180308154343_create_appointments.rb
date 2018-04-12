class CreateAppointments < ActiveRecord::Migration[5.1]
  def change
    create_table :appointments do |t|
      t.belongs_to :patient
      t.belongs_to :professional
      t.text       :reason
      t.datetime :appointment_time
      t.belongs_to :medical_center
      t.string     :location

      t.string     :update_by

      t.timestamps
      t.timestamps
    end
  end
end
