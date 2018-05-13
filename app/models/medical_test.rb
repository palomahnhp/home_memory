class MedicalTest < ApplicationRecord
  paginates_per 10

  belongs_to :history
  belongs_to :medical_center, optional: true

  has_many   :analysis_results, inverse_of: :medical_test
  has_many   :analytical_items, through: :analysis_results

  accepts_nested_attributes_for :analysis_results, reject_if: :all_blank, allow_destroy: true

  include Documentable
  documentable max_documents_allowed: 10,
               max_file_size: 3.megabytes,
               accepted_content_types: [ "application/pdf",
                                         "image/jpeg",
                                         'image/png']

  validates_presence_of :name, :performed_at, :medical_center_id

  scope :by_user, ->(user) { where(history: History.user(user) ) }

  def initialize_analysis_results
    AnalyticalGroup.all.each do |group|
      group.analytical_items.each do |item|
        analysis_results.new(analytical_item: item, unit: item.unit)
      end
    end
  end
end
