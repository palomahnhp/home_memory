class SpecialitiesImporter < BaseImporter
  attr_reader :filepath

  def parse
    Rails.logger.info (self.class.to_s + ' - '  + Time.zone.now.to_s + " - comienza lectura fichero: #{@filepath}")
    spreadsheet = open_spreadsheet
    Rails.logger.info (self.class.to_s + ' - '  + Time.zone.now.to_s + " - fichero leido: #{@filepath} " + spreadsheet.last_row.to_s + ' filas' )
    header = spreadsheet.row(1)

    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      parse_columns(row)
      group = Speciality.find_or_create_by(name: row[:nombre])
    end
  end

end