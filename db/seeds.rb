p 'Creating admin ...'
p 'admin mail: ' + Rails.application.secrets.admin_email
User.create!(email: Rails.application.secrets.admin_email,
             first_name: 'Admin', last_name: 'Admin',
             born_date: 30.years.ago,
             password: Rails.application.secrets.admin_password,
             password_confirmation: Rails.application.secrets.admin_password)

p  'Creating Specialities ...'
%w(Alergología Anestesiología Cardiología Gastroenterología Endocrinología Geriatría
   Hematología Infectología 'Medicina general y de familia' Nefrología Neumología Neurología Nutriología Oftalmología
   Oncología Pediatría Psiquiatría Rehabilitación Reumatología Toxicología Enfermería
   Urología).each do |reg|
     specialiy = Speciality.create(name: reg)
   end

p 'Creating medicaments ... '

medicaments = [
    {'PARACETAMOL Comp. 1 g': 'Paracetamol'}, {'IBUPROFENO Comp. recub. con película 600 mg':  'Ibuprofeno'},
    {'AMOXICILINA + ACIDO CLAVULANICO Comp. recub. con película 875/125 mg': 'Amoxicilina y ácido clavulánico'},
    {'ACFOL Comp. 5 mg': 'Ácido fólico'}, {'SILVEDERMA Crema 10 mg/g': 'Sulfadiazina argéntica'}
]

(1..5).each do |n|
  Medication.create(
      name: medicaments[n-1].keys[0],
      active_ingredient: medicaments[n-1].values[0]
  )
end
