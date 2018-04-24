class CreateHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :histories do |t|
      t.belongs_to :patient, index: true, foreign_key: true
      t.belongs_to :appointment, index: true, foreign_key: true
      t.text       :note
      t.integer    :order
      t.string     :update_at

      t.timestamps
    end
  end

end
