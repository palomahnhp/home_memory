class MedicalTest < ApplicationRecord
  belongs_to :appointment, optional: true
  belongs_to :patient
  belongs_to :professional
  belongs_to :medical_center

  has_many   :analysis_results
  has_many   :analytical_items, through: :analysis_results

  KIND = %w(Sangre, Sangre y Orina, Orina)

  scope :by_patient, ->(patient) { where(patient: patient) }
end
