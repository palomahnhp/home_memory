class Prescription < ApplicationRecord
  belongs_to :history
  belongs_to :medication

  def self.export_columns
    %W(date name)
  end

  def date
    init_at.strftime("%m/%d/%Y %H:%M")
  end
end
