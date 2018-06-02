  class BaseImporter
    attr_reader :filepath

    def initialize(extname, filepath)
      @filepath = filepath
      @extname  = extname
    end

    def run
      Rails.logger.info (self.class.to_s + ' - '  + Time.zone.now.to_s + " - Inicio con parámetro: #{@filepath}")
      parse
      notify_admin
      Rails.logger.info (self.class.to_s + ' - '  +  Time.zone.now.to_s + " - Fin de proceso:")
    end

    private

    def parse
      Rails.logger.info (self.class.to_s + ' - '  + Time.zone.now.to_s + " - comienza lectura fichero: #{@filepath}")
      spreadsheet = open_spreadsheet
      Rails.logger.info (self.class.to_s + ' - '  + Time.zone.now.to_s + " - fichero leido: #{@filepath} " + spreadsheet.last_row.to_s + ' filas' )
      header = spreadsheet.row(1)

      (2..spreadsheet.last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        model = self.class.to_s
        model.slice! "Importer"
        reg = eval(model).find_or_create_by(row)
        reg.add_prospect(row['name']) if reg.respond_to? :add_prospect
      end
    end

    def notify_admin
      if @start.blank?
        puts '*** notify_Admin **** Ejecutado importer '
        @start = true
      else
        puts '*** notify_Admin **** Ejecutado importer '
      end
    end

    def open_spreadsheet
      case @extname
        when ".csv" then Roo::Csv.new(@filepath, nil, :ignore)
        when ".xls" then Roo::Excel.new(@filepath)
        when ".xlsx" then Roo::Excelx.new(@filepath)
        else raise "Unknown file type: #{@filepath}"
      end
    end

    def delete_file
      if File.delete(@filepath)
        Rails.logger.info (self.class.to_s + ' - '  +  Time.zone.now.to_s + " - Eliminado fichero de RPT:   #{@filepath}" )
      end
    end
  end
