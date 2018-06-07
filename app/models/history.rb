class History < ApplicationRecord

  belongs_to :medical_center, optional: true
  belongs_to :user
  belongs_to :professional, optional: true
  belongs_to :process, class_name: "History", optional: true
  belongs_to :speciality, optional: true

  has_many :medical_tests, inverse_of: :history, dependent: :destroy
  accepts_nested_attributes_for :medical_tests, allow_destroy: true

  has_many :prescriptions, inverse_of: :history, dependent: :destroy
  accepts_nested_attributes_for :prescriptions, allow_destroy: true

  KIND = %w( appointment annotation )

  include Documentable
  documentable max_documents_allowed: 10,
               max_file_size: 3.megabytes,
               accepted_content_types: [ "application/pdf",
                                         "image/jpeg",
                                         'image/png']

  default_scope -> { order(event_at: :desc) }

  scope :initials,      -> { where( initial_process: 1 ) }
  scope :pending,       -> { where( "event_at > ?", Time.now) }
  scope :no_pending,    -> { where( "event_at <= ?", Time.now) }
  scope :appointments,  -> { where( kind: 'appointment' ) }
  scope :annotations,   -> { where( kind: 'annotation' ) }
  scope :user,          -> (user) { where( user: user ) }
  scope :by_process,    -> (process) { where( process: process ) }

  validates_presence_of :event_at
  validates_presence_of :reason

  def self.ransackable_attributes(auth_object = nil)
    %w(note reason kind event_at) + _ransackers.keys
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

  def appointment?
    kind == 'appointment'
  end

  def has_process?
    process.present? # && process_id != id
  end

  def process_name
     event_at.strftime("%m/%d/%Y") + ' ' + reason
  end

  def self.export_columns
    %W(date speciality_name professional_name reason medical_center_name process_name note )
  end

  def professional_name
    professional&.full_name
  end

  def medical_center_name
    medical_center&.name
  end

  def process_namee
    process&.name
  end

  def speciality_name
    speciality&.name
  end

  def date
    event_at&.strftime("%m/%d/%Y %H:%M")
  end

end


