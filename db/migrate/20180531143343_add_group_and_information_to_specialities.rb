class AddGroupAndInformationToSpecialities < ActiveRecord::Migration[5.1]
  def change
    add_column :specialities, :group,      :string
    add_column :specialities, :information, :text
  end
end
