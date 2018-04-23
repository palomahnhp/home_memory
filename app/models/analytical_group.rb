class AnalyticalGroup  < ApplicationRecord
  has_many :analytical_items
  has_many :analytical_subgroups

end