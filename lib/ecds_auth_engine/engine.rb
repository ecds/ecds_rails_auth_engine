require 'rails_api_auth'

module EcdsAuthEngine
  class Engine < ::Rails::Engine
    isolate_namespace EcdsAuthEngine
    config.generators.api_only = true
    # config.autoload_paths << File.expand_path("models", __dir__)
    initializer :append_migrations do |app|
      unless app.root.to_s.match root.to_s
        config.paths['db/migrate'].expanded.each do |expanded_path|
          app.config.paths['db/migrate'] << expanded_path
        end
      end
    end
  end
end
