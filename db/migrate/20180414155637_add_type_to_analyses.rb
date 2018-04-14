class AddTypeToAnalyses < ActiveRecord::Migration[5.1]
  def change
    add_column :analyses, :type, :string
  end
end
