class Prescription < ApplicationRecord
  belongs_to :history
  belongs_to :medication
end
