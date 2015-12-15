require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Placemat
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    # Pull in imgix and paperclip configs
    config.imgix = Rails.application.config_for(:imgix)
    config.s3 = Rails.application.config_for(:s3)

    # paperclip config
    config.paperclip_defaults = {
        use_timestamp: false, # the cache buster shouldn't be needed, because imgix
        storage: :s3,
        s3_credentials: {
          bucket: Rails.configuration.s3['bucket'],
          access_key_id: Rails.configuration.s3['access_key_id'],
          secret_access_key: Rails.configuration.s3['secret_access_key'],
        }
    }
  end
end
