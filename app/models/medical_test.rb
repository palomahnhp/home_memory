class MedicalTest < ApplicationRecord
  paginates_per 10

  belongs_to :appointment, optional: true
  belongs_to :patient
  belongs_to :professional
  belongs_to :medical_center

  has_many   :analysis_results, inverse_of: :medical_test
  has_many   :analytical_items, through: :analysis_results
  accepts_nested_attributes_for :analysis_results , reject_if: :all_blank, allow_destroy: true

  scope :by_patient, ->(patient) { where(patient: patient) }

end
