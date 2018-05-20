class Speciality < ApplicationRecord
  has_many :professional
  has_many :histories, through: :professional

  default_scope { order(:name) }

  def self.ransackable_attributes(auth_object = nil)
    %w(name) + _ransackers.keys
  end
end
