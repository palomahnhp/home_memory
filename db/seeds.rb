require 'database_cleaner'

DatabaseCleaner.clean_with :truncation
DatabaseCleaner.clean

p 'Creating admin user ...'
p 'admin mail: ' + Rails.application.secrets.admin_email

User.create!(email: Rails.application.secrets.admin_email,
             first_name: 'Admin', last_name: 'Admin',
             born_date: 30.years.ago,
             password: Rails.application.secrets.admin_password,
             password_confirmation: Rails.application.secrets.admin_password)

p  'Creating Specialities ...'
   SpecialityImporter.new('.xlsx',
                            'public/import/Especialidades.xlsx').run

p 'Creating medicaments ... '
   MedicationImporter.new('.xlsx',
                         'public/import/Medicamentos.xlsx').run

p 'Creating medical center ... '

  MedicalCenterImporter.new('.xlsx', 'public/import/CentrosMedicos.xlsx').run



