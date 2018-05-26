class AddInitialProcess < ActiveRecord::Migration[5.1]
  def change
    add_column :histories, :initial_process, :boolean
  end
end
