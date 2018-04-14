class AnalysisImporter < BaseImporter
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
        @patient = Patient.find_by(nickname: row['paciente'])
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
        analysis = Analysis.find_or_create_by( extracted_at: data[0].to_date,
                                               patient: @patient,
                                               medical_center: @center,
                                               professional: @professional
                                               )

        AnalysisResult.find_or_create_by( analytical_item: item,
                                          analysis: analysis,
                                          amount:   data[1]
                                          )
      end
=begin
      rpt = Rpt.find_or_create_by(year: row["year"], sapid_area: row["sapid_area"],
                                  sapid_unidad: row["sapid_unidad"], id_puesto: row["id_puesto"])
      rpt.attributes   = row.to_hash
      rpt.organization = FirstLevegroup_datlUnit.find_by(sapid_unit: row["sapid_area"]).organization
      rpt.unit         = Unit.find_by(sap_id: row["sapid_unidad"]).presence
      Rails.logger.info (self.class.to_s + ' - '  + Time.zone.now.to_s + " - procesado registro: " + i.to_s)
      begin
        rpt.save!
      rescue
        Rails.logger.info (self.class.to_s + ' - '  +  Time.zone.now.to_s + " - Error actualizando RPT: #{@filepath}" +
            rpt.errors.to_s)
      end
    end
=end
#      delete_file
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

