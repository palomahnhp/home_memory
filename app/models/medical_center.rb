class MedicalCenter < ApplicationRecord
  has_many :professionals
  has_many :histories

  default_scoped { order( :name ) }

  def self.select_option
    all.order(:name).map{|p| [ p.name, p.id ] }
  end

  def self.ransackable_attributes(auth_object = nil)
    %w(name) + _ransackers.keys
  end
end
