class CreateHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :histories do |t|
      t.belongs_to :patient
      t.belongs_to :appointment
      t.belongs_to :history

      t.text   :note
      t.string :update_at

      t.timestamps
    end
  end
end
