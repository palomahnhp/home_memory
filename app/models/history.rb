class History < ApplicationRecord
  has_many :medical_tests
  belongs_to :medical_center, optional: true
  belongs_to :patient
  belongs_to :professional, optional: true
  has_many :prescriptions

  KIND = %w( cita anotación )

  default_scope -> { order(event_at: :desc) }
  scope :pending, -> { where( "event_at > ?", Time.now) }
  scope :no_pending, -> { where( "event_at <= ?", Time.now) }
  scope :appointments, -> { where( kind: 'cita' ) }
  scope :annotations,  -> { where( kind: 'anotación' ) }
  scope :patient, -> (patient) { where( patient: patient ) }

  def self.ransackable_attributes(auth_object = nil)
    %w(note reason) + _ransackers.keys
  end

  def self.select_option(patient)
    patient(patient).appointments.map { |history| [history.id, history.professional.full_name + ' - ' + history.event_at.to_s] }
  end
end
