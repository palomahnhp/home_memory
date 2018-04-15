class Patient < ApplicationRecord
  has_many :appointments,   inverse_of: :patient
  has_many :professionals,  through: :appointments
  has_many :medical_tests
  has_many :medical_tests,  through: :appointments
  has_many :prescriptions,   through: :appointments
  has_many :medications,    through: :precriptions
  has_many :histories

  accepts_nested_attributes_for :appointments, reject_if: :all_blank, allow_destroy: true

  def full_name
    firstname + " " + surname
  end

end
