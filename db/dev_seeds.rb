require 'database_cleaner'
DatabaseCleaner.clean_with :truncation
DatabaseCleaner.clean

p 'Creating user ...'
[
    ['cherry@gmail.com', 'cherry', 'Sara',   'Beltrán Hernández', '1998/03/26'],
    ['popi@gmail.com', 'paloma', 'Paloma', 'Hernández Navarro', '1961/08/02'],
    ['jb@gmail.com', 'paloma',   'Justo',  'Beltrán Vicente', '1964/06/22']
].each do |reg|
  user =  User.create!(email:reg[0], first_name: reg[2], last_name: reg[3],
                       born_date: reg[4],
                       password:  reg[1],
                       password_confirmation:  reg[1])
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
   Hematología Infectología 'Medicina general y de familia' Nefrología Neumología Neurología Nutriología Oftalmología
   Oncología Pediatría Psiquiatría Rehabilitación Reumatología Toxicología Enfermería
   Urología).each do |reg|
   specialiy = Speciality.create(name: reg)

end
p  'Creating Profesionals ...'
 [
     ['Rebeca', 'Manzano', 'Gastroenterología', 'Hospital del Sureste'],
     ['Mª José', 'Garrido', 'General', 'Centro de Salud Primero de Mayo'],
     ['Marta', 'Fernando', 'Enfermería', 'Centro de Salud Primero de Mayo']
 ].each do |reg|
   professional =  Professional.create(first_name: reg[0], last_name: reg[1],
                                       speciality: Speciality.find_by(name: reg[2]),
                                       medical_center: MedicalCenter.find_by(name: reg[3]))

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


p 'Creating histories ... '

  User.all.each do |user|
    (1..3).each do |n|
      a = History.create!(user: user,
                         event_at:rand((Time.current - 2.years) .. (Time.current + 3.months)),
                         kind: 'appointment',
                         professional: Professional.all.shuffle.first,
                         medical_center: MedicalCenter.all.shuffle.first,
                         reason: Faker::Lorem.paragraph,
                         location: 'planta ' + (rand(1..5).to_s) +' despacho ' + (rand(102..215).to_s),
                         note: "<p>#{Faker::Lorem.paragraphs.join('</p><p>')}</p>"
                         )
    end
    (1..2).each do |n|
      a = History.create!(user: user,
                         event_at:rand((Time.current - 2.years) .. (Time.current + 3.months)),
                         kind: 'annotation',
                         medical_center: MedicalCenter.all.shuffle.first,
                         reason: Faker::Lorem.paragraph,
                         location: 'planta ' + (rand(1..5).to_s) +' despacho ' + (rand(102..215).to_s),
                         note: "<p>#{Faker::Lorem.paragraphs.join('</p><p>')}</p>")
    end
  end

 (1..15).each do
   type = NameTest.all.shuffle.first
   history = History.appointments.shuffle.first

   test = MedicalTest.create!(name: type.name,
 #                            kind: type.code,
                             history: history,
                             medical_center: MedicalCenter.all.shuffle.first,
                             performed_at: Date.today - rand(40..233).days,
                             performed_in: 'planta 0, sala 4',
     )
 end

 (1..15).each do
   medication = Medication.all.shuffle.first
   history = History.appointments.shuffle.first

   test = Prescription.create!(history: history,
                               medication: medication,
                              init_at: Date.today - rand(40..233).days,
                              end_at:  Date.today + rand(0..40).days,
                              posology: '1 / 24 h'
     )
 end


