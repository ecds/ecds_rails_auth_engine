# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'ecds_rails_auth_engine/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'ecds_rails_auth_engine'
  s.version     = EcdsRailsAuthEngine::VERSION
  s.authors     = ['Jay Varner']
  s.email       = ['jay.varner@emory.edu']
  s.homepage    = 'https://github.com/ecds'
  s.summary     = 'Token based authentication engine for ECDS projects.'
  s.description = 'Token based authentication engine for ECDS projects.'
  s.license     = 'MIT'

  s.files = Dir[
    '{app,config,db,lib}/**/*',
    'MIT-LICENSE',
    'Rakefile',
    'README.md'
  ]

  s.add_dependency 'cancancan'
  s.add_dependency 'httparty'
  s.add_dependency 'jwt'
  s.add_dependency 'rails'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'factory_bot_rails'
  s.add_development_dependency 'faker'
  s.add_development_dependency 'webmock'
end
