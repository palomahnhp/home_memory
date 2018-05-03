p 'Creating user ...'
user = User.find_or_create_by!(email: Rails.application.secrets.user_email) do |user|
  user.password = Rails.application.secrets.user_password
  user.password_confirmation = Rails.application.secrets.user_password

end

p  'Creating Specialities ...'
%w(Alergología Anestesiología Cardiología Gastroenterología Endocrinología Geriatría
   Hematología Infectología General Nefrología Neumología Neurología Nutriología Oftalmología
   Oncología Pediatría Psiquiatría Rehabilitación Reumatología Toxicología Enfermería
   Urología).each do |reg|
   specialiy = Speciality.create(name: reg)
   p specialiy.name
end

