class NameTest < ApplicationRecord
  has_many :medical_tests

  default_scope { order(:name) }
end
