class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :professionals,  through: :histories
  has_many :medical_tests,  through: :histories
  has_many :prescriptions,  through: :histories
  has_many :medications,    through: :prescriptions
  has_many :histories

  validates_presence_of :born_date, :first_name, :last_name

  include Documentable
  documentable max_documents_allowed: 10,
               max_file_size: 3.megabytes,
               accepted_content_types: [ "application/pdf",
                                         "image/jpeg",
                                         'image/png']
  def full_name
    first_name + " " + last_name
  end

  def age
    Age.in_years(born_date)
  end


  def self.ransackable_attributes(auth_object = nil)
    %w(first_name last_name public_health_org private_health_company) + _ransackers.keys
  end

end
