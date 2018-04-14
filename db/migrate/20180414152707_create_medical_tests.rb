class CreateMedicalTests < ActiveRecord::Migration[5.1]
  def change
    create_table :medical_tests do |t|
      t.belongs_to :appointment
      t.string     :name
      t.time       :date
      t.text       :instructions
      t.text       :results

    end
  end
end
