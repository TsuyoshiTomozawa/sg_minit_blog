require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SgMiniBlog
  class Application < Rails::Application
    config.load_defaults 7.0
    config.time_zone = 'Asia/Tokyo'
    config.i18n.default_locale = :ja

    config.generators do |g|
      g.test_framework :rspec,
                       view_specs: false,
                       helper_specs: false,
                       routing_specs: false
    end
  end
end
