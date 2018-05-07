class AnalysisResult  < ApplicationRecord
  belongs_to :analytical_item
  belongs_to :medical_test

  validates_presence_of :analytical_item, :amount
  validates_numericality_of :amount

  scope :by_analysis, -> (analysis) { where(medical_test: analysis) }
  scope :by_analytical_item, -> (analytical_item) { where(analytical_item: analytical_item) }

end