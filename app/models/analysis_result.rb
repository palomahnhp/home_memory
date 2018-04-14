class AnalysisResult  < ApplicationRecord
  belongs_to :analytical_item
  belongs_to :analysis

  scope :by_analysis, -> (analysis) { where(analysis: analysis) }
  scope :by_analytical_item, -> (analytical_item) { where(analytical_item: analytical_item) }

end