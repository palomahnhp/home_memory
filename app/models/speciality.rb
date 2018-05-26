class Speciality < ApplicationRecord
  has_many :professionals
  has_many :histories

  default_scope { order(:name) }

  def self.ransackable_attributes(auth_object = nil)
    %w(name) + _ransackers.keys
  end
end
