class Professional < ApplicationRecord
  belongs_to :speciality
  belongs_to :medical_center, optional: true

  validates_presence_of :first_name, :last_name
  default_scope { order(:first_name, :last_name  ) }

  def full_name
    first_name + " " + last_name
  end

  def full_name_speciality
     first_name + " " + last_name + " - " + speciality.name
  end

  def self.select_option
    all.order(:first_name, :last_name).map{|p| [ p.full_name, p.id ] }
  end

  def self.ransackable_attributes(auth_object = nil)
    %w(last_name first_name) + _ransackers.keys
  end

end
