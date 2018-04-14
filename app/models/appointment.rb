class Appointment < ApplicationRecord
  belongs_to :patient
  belongs_to :professional
  belongs_to :medical_center
  has_many :analyses

  has_many :medical_tests
end
