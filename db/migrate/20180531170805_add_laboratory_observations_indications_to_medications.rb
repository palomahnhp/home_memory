class AddLaboratoryObservationsIndicationsToMedications < ActiveRecord::Migration[5.1]
  def change
    add_column :medications, :observations, :string
    add_column :medications, :indications, :string
    add_column :medications, :groups, :string
    remove_attachment :medications, :prospect
  end
end
