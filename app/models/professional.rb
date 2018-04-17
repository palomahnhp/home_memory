class Professional < ApplicationRecord
  belongs_to :speciality
  belongs_to :medical_center

  def full_name
    firstname + " " + surname
  end

  def self.select_option
    all.order(:firstname, :surname).map{|p| [ p.full_name, p.id ] }
  end
end
