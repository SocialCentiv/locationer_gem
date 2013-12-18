class CreateGeoData < ActiveRecord::Migration
  def change
    create_table :locationer_geo_data do |t|
      t.string :country
      t.string :city_name
      t.string :state
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
