class History < ApplicationRecord

  has_many :medical_tests, dependent: :destroy
  accepts_nested_attributes_for :medical_tests, allow_destroy: true

  belongs_to :medical_center, optional: true
  belongs_to :user
  belongs_to :professional, optional: true
  has_many :prescriptions, dependent: :destroy
  accepts_nested_attributes_for :prescriptions, allow_destroy: true

  KIND = %w( appointment annotation )

  include Documentable
  documentable max_documents_allowed: 10,
               max_file_size: 3.megabytes,
               accepted_content_types: [ "application/pdf",
                                         "image/jpeg",
                                         'image/png']

  default_scope -> { order(event_at: :desc) }

  scope :pending, -> { where( "event_at > ?", Time.now) }
  scope :no_pending, -> { where( "event_at <= ?", Time.now) }
  scope :appointments, -> { where( kind: 'appointment' ) }
  scope :annotations,  -> { where( kind: 'annotation' ) }
  scope :user, -> (user) { where( user: user ) }

  validates_presence_of :event_at, :professional

  def self.ransackable_attributes(auth_object = nil)
    %w(note reason kind) + _ransackers.keys
  end

  def self.select_option(user)
    user(user).appointments.map { |history| [history.id, history.professional.full_name + ' - ' + history.event_at.to_s] }
  end

  def self.kinds
    KIND.map { |kind| [I18n.t("activerecord.attributes.history.#{kind}"), kind]}
  end

  def pending
    "pending" if event_at >  Time.now
  end
end
