class AnalyticalItem  < ApplicationRecord
  belongs_to :analytical_group
  has_many :analysis_results

  default_scope { order(:name) }
  scope :by_group, ->(group) { where(analytical_group: group) }

end