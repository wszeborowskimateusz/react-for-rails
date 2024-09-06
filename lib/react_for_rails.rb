# frozen_string_literal: true

require_relative 'react_for_rails/version'
require 'react_for_rails/helper'

module ReactForRails
  class Railtie < Rails::Railtie
    initializer 'react_for_rails.add_helpers' do
      ActiveSupport.on_load(:action_view) do
        include ReactForRails::Helper
      end
    end
  end
end
