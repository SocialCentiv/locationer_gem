$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "locationer/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "locationer"
  s.version     = Locationer::VERSION
  s.authors     = ["Tomasz Grabowski"]
  s.email       = ["belike81@gmail.com"]
  s.homepage    = "http://www.tomaszgrabowski.com"
  s.summary     = "Library to provide an API for giving nearby cities in US based on the given city."
  s.description = "Locationer is an mountable API that provides functionality of providing results of cities nearby a given city based on the provided range."

  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}){|f|File.basename(f)}
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.add_dependency "rails", "~> 4.0"
  s.add_dependency "ruby-progressbar"

  s.add_development_dependency "pg"
  s.add_development_dependency "byebug"
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency 'factory_girl_rails'  
  s.add_development_dependency 'annotate', ">=2.5.0"  
  s.add_development_dependency 'simplecov'  
end
