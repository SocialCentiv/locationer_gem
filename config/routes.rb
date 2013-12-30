
Locationer::Engine.routes.draw do
  #mount Locationer::LocationData::API => '/'
  resources :countries, only: [:show, :index]

  resources :subdivisions, only: [:show, :index]

  resources :cities, only: [:index]
end
