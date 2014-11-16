# Webpack::Rails

Replace Sprockets with webpack.

Why? Because Sprockets is 2011 and we've moved on. We shouldn't be treating our JS and CSS as a big ball of mud, but as code with depedencies we can track. We should be supporting the creation of both simple Rails applications and complex, modern, modular Javascript web applications. Webpack lets us do this but integrating it with Rails is tricky. This gem hopes to solve that.

**This is very much still alpha quality software. Do not use in your production system**

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'webpack-rails'
```

Comment out the sprockets railstie in `application.rb`

```ruby
# require "sprockets/railtie"
require "webpack/railtie"
```

Change your `application.css` and `application.js` to remove any sprockets manifest directives.
Instead change your `application.js` to:

```js
require('../stylesheets/application.css');
```

at the top. Finally the webpack config file `config/webpack.development.js`

```js
var ExtractTextPlugin = require("extract-text-webpack-plugin");
module.exports = {
  context: __dirname + '/../app/assets/javascripts',
  entry: './application.js',
  output: {
    path: __dirname + '/../tmp/assets',
    filename: 'application.js'
  },
  module: {
    loaders: [
      { test: /\.css$/, loader: ExtractTextPlugin.extract("style-loader", "css-loader") },
      {
        test: /\.scss$/,
        loader: "style!css!sass?outputStyle=expanded&includePaths[]=" +
            (path.resolve(__dirname, './bower_components/bootstrap-sass-official'))
      }
    ]
  },
  plugins: [
    new ExtractTextPlugin("application.css")
  ]
};
```

## TODO:

See the issues list for specifics but roughly:

1. Create a rails generator installer task.
2. Document the node_modules required and install these as part of the installation process.
3. Explore the possibility of hiding the node_modules into `vendor`
4. Change the development compilation step not run webpack on every request to `/assets/*`
5. Explore how to do production deploys.
6. Create a `rake assets:precompile` task.


## Contributing

1. Fork it ( https://github.com/[my-github-username]/webpack-rails/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
