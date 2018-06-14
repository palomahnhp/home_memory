class AddCommentToAnalysis < ActiveRecord::Migration[5.1]
  def change
    add_column :analytical_items, :comments, :text
    add_column :analytical_items, :result_type, :string
    add_column :analysis_results, :comments, :text
    add_column :analysis_results, :result, :string
  end
end
