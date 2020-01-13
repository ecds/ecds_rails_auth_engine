# frozen_string_literal: true

module EcdsRailsAuthEngine
  #
  # <Description>
  #
  class Engine < ::Rails::Engine
    isolate_namespace EcdsRailsAuthEngine

    config.generators.api_only = true
    config.generators.test_framework = :rspec
    config.generators.fixture_replacement = :factory_bot
    config.generators.factory_bot = { dir: 'spec/factories' }

    initializer :append_migrations do |app|
      unless app.root.to_s.match? root.to_s
        config.paths['db/migrate'].expanded.each do |expanded_path|
          app.config.paths['db/migrate'] << expanded_path
        end
      end
    end
  end
end
