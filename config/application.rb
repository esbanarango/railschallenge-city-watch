require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CityWatch
  class Application < Rails::Application
    config.api_only = true

    config.autoload_paths += Dir[
      Rails.root.join('app', 'models', '{**}'),
      Rails.root.join('app', 'services', '{**}'),
      Rails.root.join('app', 'responses', '{**}')
    ]

    config.active_record.raise_in_transactional_callbacks = true
  end
end
