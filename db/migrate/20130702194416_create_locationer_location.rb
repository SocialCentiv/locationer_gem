class CreateGeoData < ActiveRecord::Migration
  def change
    create_table "locationer_locations" do |t|
      t.string    :name
      t.string    :asciiname
      t.text      :alternatenames
      t.float     :latitude
      t.float     :longitude
      t.string    :feature_class
      t.string    :feature_code
      t.string    :admin1_code
      t.integer   :population
      t.string    :timezone
      t.datetime  :modification_date 
    end
  end
end
