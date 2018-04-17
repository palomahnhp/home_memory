class CreateNameTests < ActiveRecord::Migration[5.1]
  def change
    create_table :name_tests do |t|
      t.string :name
      t.string :code

    end
  end
end
