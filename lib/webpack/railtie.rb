require 'rails'
require 'rails/railtie'
require 'webpack/rails/helper'
require 'webpack/rails/environment'

module Webpack
  class Railtie < ::Rails::Railtie
    config.after_initialize do |app|
      ActiveSupport.on_load(:action_view) do
        include Webpack::Rails::Helper
      end

      app.routes.prepend do
        mount Webpack::Rails::Environment.new(File.join(app.config.root, 'tmp', 'assets')) => '/assets'
      end
    end
  end
end
