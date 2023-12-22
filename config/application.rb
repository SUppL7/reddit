require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Reddit
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    config.autoload_paths << "#{Rails.root}/lib"
    # Автозагрузка всех языковых файлов

    config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # Дефолтовый язык
    config.i18n.default_locale = :ru

    # Возврат к английскому при ошибках
    config.i18n.fallbacks = {'ru' => 'en'}
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.time_zone = "Moscow"
    # config.eager_load_paths << Rails.root.join("extras")
  end
