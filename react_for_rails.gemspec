# frozen_string_literal: true

require_relative "lib/react_for_rails/version"

Gem::Specification.new do |spec|
  spec.name = "react_for_rails"
  spec.version = ReactForRails::VERSION
  spec.authors = ["Mateusz Wszeborowski"]
  spec.email = ["wszeborowskimateusz@gmail.com"]

  spec.summary = "Enables using React components in Rails apps. Inspired by react_on_rails"
  spec.homepage = "https://github.com/wszeborowskimateusz/react-for-rails"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/wszeborowskimateusz/react-for-rails"
  spec.metadata["changelog_uri"] = "https://github.com/wszeborowskimateusz/react-for-rails/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", ">= 5.2"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
