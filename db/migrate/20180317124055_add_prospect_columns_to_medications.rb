class AddProspectColumnsToMedications < ActiveRecord::Migration[5.1]
  def up
    add_attachment :medications, :prospect
  end

  def down
    remove_attachment :medications, :prospect
  end
end
