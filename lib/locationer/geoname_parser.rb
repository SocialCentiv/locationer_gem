require 'csv'
require 'ruby-progressbar'

def number_with_delimiter(number, delimiter=",", separator=".")
  begin
    parts = number.to_s.split('.')
    parts[0].gsub!(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1#{delimiter}")
    parts.join separator
  rescue
   number
  end
end

module Locationer
  class GeonameRow
    SUBDIVISION_FEATURE_CLASS = "A"
    SUBDIVISION_FEATURE_CODE =  "ADM1"

    CITY_FEATURE_CLASS = "P"
    CITY_FEATURE_CODE =  "PPL"    

    FIELD_INDEX = {geonameid: 0, 
      name: 1,
      asciiname: 2,
      alternatenames: 3,
      latitude: 4,
      longitude: 5,
      feature_class: 6,
      feature_code: 7,
      country_code: 8,
      cc2: 9,
      admin1_code: 10,
      admin2_code: 11,
      admin3_code: 12,
      admin4_code: 13,
      population: 14,
      elevation: 15,
      dem: 16,
      timezone: 17,
      modification_date: 18}

    def method_missing(meth, *args, &block)
      if @row && FIELD_INDEX.has_key?(meth)
        return @row[FIELD_INDEX[meth]]
      else
        super 
      end
    end

    def fields
      FIELD_INDEX.keys
    end

    def initialize(row)
      @row = row
    end

    def subdivision
      send(:admin1_code) 
    end

    def subdivision?
      send(:feature_code) == SUBDIVISION_FEATURE_CODE &&
      send(:feature_class) == SUBDIVISION_FEATURE_CLASS
    end

    def city?
      send(:feature_code) == CITY_FEATURE_CODE &&
      send(:feature_class) == CITY_FEATURE_CLASS
    end    

    def to_hash(allowed_keys = nil)
      obj_hash = self.fields.inject({}) {|h,e| h.merge({e => send(e)})}

      if allowed_keys
        obj_hash.keys.each do |key|
          obj_hash.delete(key) unless allowed_keys.include?(key.to_s)
        end
      end

      obj_hash
    end
  end

  class GeonameParser
    def initialize(file_path, options = {})
      @file_path = file_path
    end

    def extract_city_subdivision(options = {})
      use_progressbar = options.fetch(:progressbar){true}

      raise "File does not exist!" unless File.exist?(@file_path)

      total = (`wc -l #{@file_path}`).to_i

      puts "Processing #{number_with_delimiter(total, ',')} geoname records: extracting cities and subdivisions"
      pg = ProgressBar.create(:format => '%a <%B> %p%% %t', :total => total) if use_progressbar
      counter = 1
      File.open("unprocessed_records.csv", 'a') do |upf|
        File.open(@file_path, 'r') do |f1|  
          File.open("#{File.basename( @file_path, ".csv")}-cities-subdivs.txt", 'a') do |cities_subs|
            while line = f1.gets  
              begin
                CSV.parse(line.chomp.gsub("\"", ""), :col_sep => "\t") do |row|
                  geo_row = GeonameRow.new(row)
                  if geo_row.city? || geo_row.subdivision?
                    cities_subs.puts(line.chomp) 
                  end
                  
                end      
       
              rescue => e
                # Create a new file and write to it  
                File.open("record_#{counter}.log", 'w') do |f2|  
                  f2.puts "#{e.message}"
                  f2.puts line.chomp
                end  
                upf.puts line.chomp
              end      

              counter += 1
              pg.increment if use_progressbar    
            end  
          end
        end 
      end      
    end

    def db_insert(options = {})
      use_progressbar = options.fetch(:progressbar){true}

      raise "File does not exist!" unless File.exist?(@file_path)

      total = (`wc -l #{@file_path}`).to_i

      puts "Loading #{number_with_delimiter(total, ',')} geoname records from #{File.basename(@file_path)}"
      pg = ProgressBar.create(:format => '%a <%B> %p%% %t', :total => total) if use_progressbar
      counter = 1
      File.open("unprocessed_records.csv", 'a') do |upf|
        File.open(@file_path, 'r') do |f1|  
          while line = f1.gets  
            begin
              CSV.parse(line.chomp.gsub("\"", ""), :col_sep => "\t") do |row|
                geo_row = GeonameRow.new(row)
                Locationer::Location.create(geo_row.to_hash(Locationer::Location.column_names))
              end      
     
            rescue => e
              # Create a new file and write to it  
              File.open("record_#{counter}.log", 'w') do |f2|  
                f2.puts "#{e.message}"
                f2.puts line.chomp
              end  
              upf.puts line.chomp
            end      

            counter += 1
            pg.increment if use_progressbar    
          end  
        end 
      end
    end

  end
end