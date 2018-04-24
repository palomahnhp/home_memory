class MedicalTestImporter < BaseImporter
  attr_reader :filepath

  def parse
    Rails.logger.info (self.class.to_s + ' - '  + Time.zone.now.to_s + " - comienza lectura fichero: #{@filepath}")
    spreadsheet = open_spreadsheet
    Rails.logger.info (self.class.to_s + ' - '  + Time.zone.now.to_s + " - fichero leido: #{@filepath} " + spreadsheet.last_row.to_s + ' filas' )
    header = spreadsheet.row(1)

    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      parse_columns(row)
      if i == 2
        @patient = Patient.find_by(fisrtname: row['paciente'])
        @center  = MedicalCenter.find_by(name: row['centro'])
        @professional  = Professional.find_by(firstname: row['profesional'])
      end

      group = AnalyticalGroup.find_or_create_by(name: @group_data[:name] )
      item  = AnalyticalItem.find_or_create_by(
          analytical_group: group,
          name: @item_data[:name],
          max_range: @item_data[:max_range],
          min_range: @item_data[:min_range]
      )

      @result_data.each do |data|
        extraction = data[0].to_datetime
        analysis = MedicalTest.find_or_create_by( performed_at: extraction,
                                                  performed_in: 'sala xx',
                                                  name: 'Análisis',
                                                  kind: 'de sangre',
                                                  instructions: 'Acudir en ayunas',
                                                  patient: @patient,
                                                  professional: @professional,
                                                  medical_center: @center
                                                 )
        level = 'A' if data[1].to_f  > item.max_range.to_f
        level = 'B' if data[1].to_f  < item.min_range.to_f

        AnalysisResult.find_or_create_by( analytical_item: item,
                                          medical_test: analysis,
                                          amount:   data[1],
                                          level: level
                                          )
      end
    end
  end

  private
  def parse_columns(row)
    @group_data = {
      :name => row['grupo']
    }

    @item_data = {
      :name       => row['determinación'],
      :max_range  => row['max'],
      :min_range  => row['min']
    }

    row_array = row.to_a

    @result_data = { }
     (9..50).each do |n|
       break if row_array[n].blank?
       @result_data[row_array[n][0]] = row_array[n][1]
     end
  end
end

