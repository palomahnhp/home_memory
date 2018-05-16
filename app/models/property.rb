class Property  < ApplicationRecord
  belongs_to :user

  default_scope -> { order(:order) }
  scope :by_fieldset, -> (fieldset) { where(fieldset: fieldset) }
end