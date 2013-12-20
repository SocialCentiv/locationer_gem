class CreateLocationerLocation < ActiveRecord::Migration
  def change
    create_table "locationer_locations" do |t|
      t.string    :name
      t.string    :asciiname
      t.text      :alternatenames
      t.float     :latitude
      t.float     :longitude
      t.string    :feature_class
      t.string    :feature_code
      t.string    :country_code
      t.string    :admin1_code
      t.integer   :population
      t.string    :timezone
      t.datetime  :modification_date 
    end

    add_index "locationer_locations", :asciiname
    add_index "locationer_locations", :latitude
    add_index "locationer_locations", :longitude
    add_index "locationer_locations", :feature_class
    add_index "locationer_locations", :feature_code
    add_index "locationer_locations", :admin1_code

  end
end
