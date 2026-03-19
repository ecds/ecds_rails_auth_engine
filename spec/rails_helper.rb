# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
require 'factory_bot_rails'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path("../dummy/config/environment.rb", __FILE__)

abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'rspec/rails'

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

RSpec.configure do |config|
  def response_json
    JSON.parse(response.body, symbolize_names: true)# .with_indifferent_access
    # response.body
  end

  config.include FactoryBot::Syntax::Methods

  FactoryBot.definition_file_paths = [ "spec/factories" ]

  FactoryBot.find_definitions

  config.use_transactional_fixtures = true

  config.filter_rails_from_backtrace!
end
