class Property  < ApplicationRecord
#  belongs_to :user
  belongs_to :propertible, polymorphic: true

  default_scope -> { order(:fieldset, :order) }
  scope :by_fieldset, -> (fieldset) { where(fieldset: fieldset) }
end