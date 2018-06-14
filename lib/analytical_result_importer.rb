class AnalyticalResultImporter < BaseImporter
  attr_reader :filepath, :test

  def initialize(filepath, test)
    @filepath = filepath
    @test     = test
  end

  def run
    Rails.logger.info (self.class.to_s + ' - '  + Time.zone.now.to_s + " - Inicio con parámetro: #{@filepath}")
    parse
    notify_admin
    Rails.logger.info (self.class.to_s + ' - '  +  Time.zone.now.to_s + " - Fin de proceso:")
  end

  def parse
    Rails.logger.info (self.class.to_s + ' - '  + Time.zone.now.to_s + " - comienza lectura fichero: #{@filepath}")
    spreadsheet = Roo::Excelx.new(@filepath)
    Rails.logger.info (self.class.to_s + ' - '  + Time.zone.now.to_s + " - fichero leido: #{@filepath} " + spreadsheet.last_row.to_s + ' filas' )
    header = spreadsheet.row(1)

    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      parse_columns(row)
      if @result_data.present?
        group    = AnalyticalGroup.find_or_create_by(name: @group_data[:name])
        subgroup = AnalyticalSubgroup.find_or_create_by(name: row['tipo']) if row['tipo'].present?

        item  = AnalyticalItem.find_or_create_by( analytical_group: group,
                                                  name: @item_data[:name])
        amount  = Float(@result_data) rescue false
        amount  = Float(@result_data.gsub(',', '.')) rescue false unless amount.present?
        result = @result_data

        unless amount
          result_type = 'text'
        end

        item.analytical_subgroup = subgroup if subgroup.present?
        item.result_type = result_type
        item.max_range   = @item_data[:max_range] unless item.max_range.present?
        item.min_range   = @item_data[:min_range] unless item.min_range.present?
        item.comments    = @item_data[:comments]  unless item.comments.present?
        item.unit        = @item_data[:unit]      unless item.unit.present?
        item.save

        if amount.present?
          level = 'A' if (amount.to_f  > item.max_range.to_f || @result_situacion == '>' )
          level = 'B' if (amount.to_f  < item.min_range.to_f || @result_situacion == '<' )
        end

        test = MedicalTest.find_by(id: @test)

        analisis = AnalysisResult.find_or_create_by(analytical_item_id: item.id,
                                                    medical_test_id: test.id,
                                                    amount:  amount,
                                                    result:  result,
                                                    level:   level,
                                                    unit:    item.unit,
                                                    comments: item.comments )
      end
    end
  end

  private

  def parse_columns(row)
    @group_data = {
      :name => row['capitulo']
    }

    @item_data = {
      :name       => row['determinaciones'],
      :max_range  => row['max'],
      :min_range  => row['min'],
      :unit       => row['unidades'],
      :comments   => row['comentario']
    }

    @result_data      = row['resultado']
    @result_situacion = row['situación']
  end

end

