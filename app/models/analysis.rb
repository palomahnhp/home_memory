class Analysis < ApplicationRecord
  belongs_to :patient
  belongs_to :appointment
  belongs_to :professional
  belongs_to :medical_center
  has_many   :analytical_items
end
