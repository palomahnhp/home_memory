class CreateAnalyses < ActiveRecord::Migration[5.1]
  def change
    create_table :analyses do |t|
      t.date       :extracted_at
      t.belongs_to :patient, index: true, foreign_key: true
      t.belongs_to :professional, index: true, foreign_key: true
      t.belongs_to :appointment, index: true, foreign_key: true
      t.belongs_to :medical_center, index: true, foreign_key: true

      t.timestamps
    end

    create_table :analytical_groups do |t|
      t.string  :name
      t.boolean :inactive

      t.timestamps
    end

    create_table :analytical_items do |t|
      t.string    :name
      t.belongs_to :analytical_group, index: true, foreign_key: true
      t.string    :unit
      t.string    :max_range
      t.string    :min_range
      t.boolean   :inactive

      t.timestamps
    end

    create_table :analysis_results do |t|
      t.belongs_to :analytical_item, index: true, foreign_key: true
      t.belongs_to :analysis, index: true, foreign_key: true
      t.float      :amount
      t.string     :unit
      t.string     :level
      t.string     :grade
      t.text       :interpretation

      t.timestamps
    end

  end
end
