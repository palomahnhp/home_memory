class Medication < ApplicationRecord
  include Documentable
  documentable max_documents_allowed: 3,
               max_file_size: 3.megabytes,
               accepted_content_types: [ "application/pdf",
                                         "image/jpeg",
                                         'image/png']
  default_scope -> { order( :name ) }

  def self.ransackable_attributes(auth_object = nil)
    %w(name) + _ransackers.keys
  end

  def add_prospect(name)
    return unless name.present?
    file = File.open('public/import/prospectos/' + name.downcase.gsub(/\s+/, '') + '.pdf')
    document = Document.create(title: 'Prospecto de ' + name.upcase,
                            attachment: file,
                            documentable: self)
  end
end
