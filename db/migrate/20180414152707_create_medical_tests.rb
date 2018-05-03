class CreateMedicalTests < ActiveRecord::Migration[5.1]
  def change
    create_table :medical_tests do |t|
      t.belongs_to :history
      t.belongs_to :patient
      t.string     :name
      t.string     :kind
      t.belongs_to :medical_center
      t.text       :instructions
      t.text       :report

      t.datetime   :performed_at
      t.string     :performed_in
    end

    create_table :analytical_groups do |t|
      t.string  :name
      t.boolean :inactive

      t.timestamps
    end

   create_table :analytical_subgroups do |t|
      t.string  :name
      t.belongs_to  :analytical_group
      t.boolean :inactive

      t.timestamps
    end

    create_table :analytical_items do |t|
      t.string    :name
      t.belongs_to :analytical_group, index: true, foreign_key: true
      t.belongs_to :analytical_subgroup, index: true, foreign_key: true
      t.string    :unit
      t.string    :max_range
      t.string    :min_range
      t.boolean   :inactive

      t.timestamps
    end

    create_table :analysis_results do |t|
      t.belongs_to :analytical_item, index: true, foreign_key: true
      t.belongs_to :medical_test, index: true, foreign_key: true
      t.float      :amount
      t.string     :unit
      t.string     :level
      t.string     :grade
      t.text       :interpretation

      t.timestamps
    end

  end
end
