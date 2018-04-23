class AnalyticalGroupsImporter < BaseImporter
  attr_reader :filepath

  def parse
    Rails.logger.info (self.class.to_s + ' - '  + Time.zone.now.to_s + " - comienza lectura fichero: #{@filepath}")
    spreadsheet = open_spreadsheet
    Rails.logger.info (self.class.to_s + ' - '  + Time.zone.now.to_s + " - fichero leido: #{@filepath} " + spreadsheet.last_row.to_s + ' filas' )
    header = spreadsheet.row(1)

    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      parse_columns(row)

      group = AnalyticalGroup.find_or_create_by(name: @group_data[:grupo])
      subgroup = AnalyticalSubgroup.find_or_create_by(analytical_group: group, name: @group_data[:subgrupo] )
      item  = AnalyticalItem.find_or_create_by(
          analytical_group: group,
          analytical_subgroup: subgroup,
          name: @group_data[:item],
          max_range: @group_data[:max_range],
          min_range: @group_data[:min_range],
          unit: @group_data[:unit]
      )
    end
  end

  private
  def parse_columns(row)
    @group_data = {
      :grupo    => row['grupo'],
      :subgrupo => row['subgrupo'],
      :item     => row['determinación'],
      :min_range => row['min'],
      :max_range => row['max'],
      :unit      => row['unidades']
    }

  end
end

