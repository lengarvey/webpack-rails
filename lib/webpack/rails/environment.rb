module Webpack
  module Rails
    class Environment < Rack::File
      def call(env)
        `webpack --config config/webpack.development.js`
        super(env)
      end
    end
  end
end
