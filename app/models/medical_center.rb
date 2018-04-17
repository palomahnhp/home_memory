class MedicalCenter < ApplicationRecord
  has_many :professionals
  has_many :appointments

  default_scoped { order( :name ) }

  def self.select_option
    all.order(:name).map{|p| [ p.name, p.id ] }
  end
end
