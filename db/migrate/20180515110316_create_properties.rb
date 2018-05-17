class CreateProperties < ActiveRecord::Migration[5.1]
  def change
    create_table :properties do |t|
      t.belongs_to :user
      t.string :fieldset
      t.string :name
      t.string :value
      t.integer :order
      t.string  :updated_by

      t.timestamp
    end
  end
end
