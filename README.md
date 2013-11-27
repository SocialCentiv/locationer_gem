# Locationer

## Add to gemfile
`gem 'locationer', github: 'belike81/locationer_gem'`

## Add route to your routes.rb file
`mount Locationer::Engine, at: '/locationer'`

## Run the installation script
`rake locationer:install`

## Access the location data API
`locationer/location_data/(*US or Mexico)/cities_nearby/(*city_name)`

* - provide your own value for this

## Use locationer in your own models
`city_finder = Locationer::CityFinder.new('US')`
to instantiate finder object with the desired country

`city_finder.nearby_cities(city: 'Los Angeles', state: 'CA')`
to get back an array of Locationer::GeoData objects

## Setting up Dummy rails app

For development and testing there is a dummy rails app located under `spec/dummy`.

To set it up you first have to copy over the `spec/dummy/config/database.yml.template` and modify it to your own settings.

    cp spec/dummy/config/database.yml.template spec/dummy/config/database.yml
    

Executing `locationer:install` rake task will copy over the migrations to the dummy app, run `db:migrate` and imports the location data from the US.csv and Mexico.csv files:

    cd spec/dummy
 
    bundle install

    bundle exec rake locationer:install
   
     
To setup the dummy test db for testing run this:

    bundle exec db:test:prepare
    
 
You now be able to enter the rails console in the dummy app.

    rails c
    
    

    

    



