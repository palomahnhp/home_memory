class Property  < ApplicationRecord
  belongs_to :user

  default_scope -> { order(:fieldset, :order) }
  scope :by_fieldset, -> (fieldset) { where(fieldset: fieldset) }
end