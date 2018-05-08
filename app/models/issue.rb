class Issue < ApplicationRecord
  belongs_to :user

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

  def self.ransackable_attributes(auth_object = nil)
    %w(note reason) + _ransackers.keys
  end

  def self.select_option(user)
    user(user).appointments.map { |issue| [issue.id, issue.professional.full_name + ' - ' + issue.event_at.to_s] }
  end
end
