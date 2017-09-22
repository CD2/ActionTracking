# frozen_string_literal: true

module ActionTracking
  class Engine < ::Rails::Engine
    isolate_namespace ActionTracking

    initializer :append_migrations do |app|
      config.paths['db/migrate'].expanded.each do |expanded_path|
        app.config.paths['db/migrate'] << expanded_path
      end
    end
  end
end
