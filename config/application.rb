require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MalayGroup1
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.load_defaults 6.1

    config.i18n.available_locales = [:en, :jp]
    config.i18n.default_locale = :en
  end
end
