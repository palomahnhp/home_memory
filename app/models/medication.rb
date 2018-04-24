class Medication < ApplicationRecord
  has_attached_file :prospect, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/prospect/:style/missing.png"
  validates_attachment_content_type :prospect, content_type: "application/pdf"

  include Documentable
  documentable max_documents_allowed: 3,
               max_file_size: 3.megabytes,
               accepted_content_types: [ "application/pdf",
                                         "image/jpeg",
                                         'image/png']
end
