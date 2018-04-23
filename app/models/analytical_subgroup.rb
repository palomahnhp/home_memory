class AnalyticalSubgroup  < ApplicationRecord
  has_many :analytical_items
  belongs_to :analytical_group

end