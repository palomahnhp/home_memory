class Medication < ApplicationRecord
  has_attached_file :prospect, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/prospect/:style/missing.png"
  validates_attachment_content_type :prospect, content_type: "application/pdf"
end
