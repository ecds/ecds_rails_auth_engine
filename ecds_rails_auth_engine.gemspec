$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'ecds_rails_auth_engine/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'ecds_rails_auth_engine'
  s.version     = EcdsRailsAuthEngine::VERSION
  s.authors     = ['Jay Varner']
  s.email       = ['jayvarner@gmail.com']
  s.homepage    = 'https://github.com/ecds'
  s.summary     = 'Token base authentication engine for ECDS projects.'
  s.description = 'Token base authentication engine for ECDS projects.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails'
  s.add_dependency 'rails_api_auth'
  s.add_dependency 'cancancan', '~> 2.0'
  s.add_development_dependency 'sqlite3'
end
