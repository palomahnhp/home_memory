require 'database_cleaner'
DatabaseCleaner.clean_with :truncation
DatabaseCleaner.clean

p 'Creating user ...'
user = User.find_or_create_by!(email: Rails.application.secrets.user_email) do |user|
  user.password = Rails.application.secrets.user_password
  user.password_confirmation = Rails.application.secrets.user_password

end

p  'Creating Pacients ...'
[
 ['Cherry', 'Sara',   'Beltrán Hernández', '1998/03/26'],
 ['Popi',   'Paloma', 'Hernández Navarro', '1961/08/02'],
 ['Jb',    'Justo',  'Beltrán Vicente', '1964/06/22']
].each do |reg|
  patient =  Patient.create(nickname: reg[0], firstname: reg[1], surname: reg[2], born_date: reg[3])
end

p  'Creating Centers ...'
[
 ['Hospital del Sureste', 'Arganda del Rey', 'Público',
  'http://www.madrid.org/cs/Satellite?language=es&pagename=HospitalSureste%2FPage%2FHSES_home',
  'citas.sureste@salud.madrid.org'],
 ['Centro de Salud Primero de Mayo', 'Calle Velazquez, Rivas Vaciamadrid', 'Público', '', ''],
 ['Hospital Gregorio Marañon', 'Madrid', 'Público'],
 ['Cetro Médico Lagos de Rivas', 'Av. de Levante, Rivas Vaciamadrid', 'Privado',
  'http://lagosderivas.com', ''],
].each do |reg|
  centro =  MedicalCenter.create(name: reg[0], address: reg[1], kind: reg[2], web: reg[3], email: reg[4])

end

p  'Creating Specialities ...'
%w(Alergología Anestesiología Cardiología Gastroenterología Endocrinología Geriatría
   Hematología Infectología General Nefrología Neumología Neurología Nutriología Oftalmología
   Oncología Pediatría Psiquiatría Rehabilitación Reumatología Toxicología Enfermería
   Urología).each do |reg|
   specialiy = Speciality.create(denomination: reg)

end
p  'Creating Profesionals ...'
 [
     ['Rebeca', 'Manzano', 'Gastroenterología', 'Hospital del Sureste'],
     ['Mª José', 'Garrido', 'General', 'Centro de Salud Primero de Mayo'],
     ['Marta', 'Fernando', 'Enfermería', 'Centro de Salud Primero de Mayo']
 ].each do |reg|
   professional =  Professional.create(firstname: reg[0], surname: reg[1],
                                       speciality: Speciality.find_by(denomination: reg[2]),
                                       medical_center: MedicalCenter.find_by(name: reg[3]))

 end

p 'Creating appointments ... '

  Patient.all.each do |patient|
    (1..3).each do |n|
      a = Appointment.create(patient: patient,
                         appointment_time:rand((Time.current - 2.years) .. (Time.current + 3.months)),
                         professional: Professional.all.shuffle.first,
                         medical_center: MedicalCenter.all.shuffle.first,
                         reason: Faker::Lorem.paragraph,
                         location: 'planta ' + (rand(1..5).to_s) +' despacho ' + (rand(102..215).to_s))

    end
  end

 p 'Creating histories ... '
   Appointment.all.each do |appointment|
     h = History.create(patient: appointment.patient, appointment: appointment, note: "<p>#{Faker::Lorem.paragraphs.join('</p><p>')}</p>")
   end

   (1..5).each do |n|
     History.create(
         patient: Patient.all.shuffle.first,
         note: "<p>#{Faker::Lorem.paragraphs.join('</p><p>')}</p>"
     )
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


p 'Analytic groups'
  %w(Hematología Bioquica Orina Hormonal).each do |group|
    AnalyticalGroup.create(name: group)
  end

p 'Analytical items'
  [{'Leucocitos': 'Hematología'}, {'Hematies': 'Hematología'},
   {'Trigliceridos': 'Bioquímica'}].each do |item|
    AnalyticalItem.create()
  end

p 'Medical Tests'

   tests = [{'Imagen': 'Radiografia'}, {'Imagen': 'Colonospia'}, {'Imagen': 'Resonancia magnética'},
            {'Imagen': 'Endoscopia'}, {'Ultrasonidos': 'Ecografía'}, {'Análisis': 'Análisis'},
            {'Biopsia': 'Citología'}, {'Tests': 'Prueba del aliento'},
            {'Ultrasonidos': 'Ecocardiograma'}, {'Eléctrico': 'Electrocardiograma'},
            {'Médidas': 'Audiometría'}
           ]

   tests.each do |test|
     NameTest.create(code: test.keys.first, name: test.values.first)
   end

   (1..15).each do
     type = NameTest.all.shuffle.first
     appointment = Appointment.all.shuffle.first

     test = MedicalTest.create(name: type.name,
                               kind: type.code,
                               patient: appointment.patient,
                               professional: appointment.professional,
                               appointment: appointment,
                               medical_center: MedicalCenter.all.shuffle.first,
                               performed_at: Date.today - rand(40..233).days,
                               performed_in: 'planta 0, sala 4',
       )
   end


