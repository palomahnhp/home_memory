class Appointment < ApplicationRecord
  belongs_to :patient
  belongs_to :professional
  belongs_to :medical_center

end
