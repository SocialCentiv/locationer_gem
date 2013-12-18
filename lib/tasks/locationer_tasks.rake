require "csv"

namespace :locationer do
  desc 'Install locationer gem data and run required tasks'
  task :install => :environment do
    Rake::Task['locationer:install:migrations'].execute
    Rake::Task['db:migrate'].execute
    Rake::Task['locationer:import'].execute
  end

  desc 'Import cities geo data for locationer API'
  task :import => :environment do
    gem_path = Gem.loaded_specs['locationer'].full_gem_path
    Dir.glob("#{gem_path}/db/data/domain/*.csv").each do |file_name|
      csv_import_file = Rails.root.join(file_name)
      country = File.basename(file_name, '.csv')

      CSV.foreach(csv_import_file) do |row|
        Locationer::GeoData.create! country: country, city_name: row[0], latitude: row[1], longitude: row[2], state: row[3]
      end
      puts "Finished import of #{country}.csv"
    end
    puts 'Import completed'
  end


  desc "Import Geoname Data"
  task :import_geoname => :environment do
    gem_path = Gem.loaded_specs['locationer'].full_gem_path
    Dir.glob("#{gem_path}/db/seed_data/*.csv").each do |file_name|
      csv_import_file = Rails.root.join(file_name)
      country = File.basename(file_name, '.csv')

      parser = Locationer::GeonameParser.new(csv_import_file)
      parser.db_insert

      puts "Finished import of #{file_name}"
    end
    puts 'Import completed'   
  end

  desc "Extracts Cities and Subdivision from CSV files"
  task :extract_locations => :environment do
    gem_path = Gem.loaded_specs['locationer'].full_gem_path
    Dir.glob("#{gem_path}/db/seed_data/*.csv").each do |file_name|
      csv_import_file = Rails.root.join(file_name)
      country = File.basename(file_name, '.csv')

      parser = Locationer::GeonameParser.new(csv_import_file)
      parser.extract_city_subdivision

    end
    puts 'Extraction completed'   
  end  
end


