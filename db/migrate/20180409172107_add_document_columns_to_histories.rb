class AddDocumentColumnsToHistories < ActiveRecord::Migration[5.1]
  def change
    def up
      add_attachment :histories, :document
      add_column :histories, :doc_observations, :string
    end

    def down
      remove_attachment :histories, :document
      remove_column :histories, :doc_observations
    end
  end
end
