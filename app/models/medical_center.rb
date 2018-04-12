class MedicalCenter < ApplicationRecord
  has_many :professionals
  has_many :appointments

  default_scoped { order( :name ) }
end
