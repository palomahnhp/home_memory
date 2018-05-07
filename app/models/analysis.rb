class Analysis < ApplicationRecord
  belongs_to :user
  belongs_to :appointment, optional: true

  belongs_to :professional
  belongs_to :medical_center
  has_many   :analysis_results
  has_many   :analytical_items, through: :analysis_results

  TYPES = %w(Sangre, Sangre y Orina, Orina)

end
