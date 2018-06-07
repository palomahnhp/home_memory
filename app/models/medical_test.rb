class MedicalTest < ApplicationRecord
  paginates_per 10

  belongs_to :history
  belongs_to :medical_center, optional: true

  has_many   :analysis_results, inverse_of: :medical_test
  accepts_nested_attributes_for :analysis_results, reject_if: :all_blank, allow_destroy: true
  has_many   :analytical_items, through: :analysis_results

  include Documentable
  documentable max_documents_allowed: 10,
               max_file_size: 3.megabytes,
               accepted_content_types: [ "application/pdf",
                                         "image/jpeg",
                                         'image/png']

  validates_presence_of :name, :performed_at, :medical_center_id

  scope :by_user, ->(user) { where(history: History.user(user) ) }
  scope :pending, -> { where( "performed_at > ?", Time.now) }

  def initialize_analysis_results
    AnalyticalGroup.all.each do |group|
      group.analytical_items.each do |item|
        analysis_results.new(analytical_item: item, unit: item.unit)
      end
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    %w(name performed_at) + _ransackers.keys
  end

  def self.export_columns
    %W(date name medical_center_name)
  end

  def medical_center_name
    medical_center&.name
  end

  def professional_name
    professional&.name
  end
end
