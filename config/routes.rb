
Locationer::Engine.routes.draw do
  #mount Locationer::LocationData::API => '/'
  resources :countries, only: [:show]

  resources :subdivisions, only: [:show]

  resources :cities, only: [:index]
end
