class Professional < ApplicationRecord
  belongs_to :speciality
  belongs_to :medical_center

  def full_name
    firstname + " " + surname
  end
end
