class CreatePatients < ActiveRecord::Migration[5.1]
  def change
    create_table :patients do |t|
      t.string :nickname
      t.string :firstname
      t.string :surname
      t.date   :born_date

      t.timestamps
    end
  end
end
