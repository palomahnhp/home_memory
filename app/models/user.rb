class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :histories
  has_many :professionals,  through: :histories
  has_many :medical_tests,  through: :histories
  has_many :prescriptions,  through: :histories
  has_many :medications,    through: :prescriptions
  has_many :issues

  include Documentable
  documentable max_documents_allowed: 10,
               max_file_size: 3.megabytes,
               accepted_content_types: [ "application/pdf",
                                         "image/jpeg",
                                         'image/png']

  has_many :properties, inverse_of: :user, dependent: :destroy
  accepts_nested_attributes_for :properties, reject_if: :all_blank, allow_destroy: true

  def full_name
    first_name + " " + last_name
  end

  def age
    Age.in_years(born_date)
  end

  def self.ransackable_attributes(auth_object = nil)
    %w(first_name last_name public_health_org private_health_company) + _ransackers.keys
  end

  def data_fieldsets
    properties.pluck(:fieldset).uniq
  end
end
