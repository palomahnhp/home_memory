class Prescription < ApplicationRecord
  belongs_to :appointment
  belongs_to :proffesional, throught: :appointment

end
