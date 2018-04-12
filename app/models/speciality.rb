class Speciality < ApplicationRecord
  has_many :professional
  default_scope { order(:denomination) }
end
