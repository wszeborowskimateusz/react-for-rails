# ReactForRails

Lightweight Ruby gem + npm package to add React components to Rails app. Inspired by ReactOnRails.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add react_for_rails

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install react_for_rails

Add npm package to your package.json

    $ yarn add react-for-rails

## Usage

    $ ReactForRails.register({Component1, Component2}) // In your javascript
    $ react_component('Component1', props: {something: 'Test'}) // In your Rails view

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/wszeborowskimateusz/react_for_rails.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
