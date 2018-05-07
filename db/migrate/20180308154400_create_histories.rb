class CreateHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :histories do |t|
      t.datetime   :event_at
      t.string     :kind
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :professional, index: true, foreign_key: true
      t.belongs_to :medical_center, index: true, foreign_key: true
      t.text       :reason
      t.string     :location
      t.text       :note
      t.integer    :order

      t.timestamps
    end
  end

end
