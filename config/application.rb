require_relative 'boot'

require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "action_controller/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Api
  class Application < Rails::Application
    config.middleware.use Rack::Deflater

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Don't generate system test files.
    config.generators.system_tests = nil

    #config.sequel.schema_format = :sql
    #config.sequel.search_path = %w(mine public)
    config.sequel.after_connect = proc do
      Sequel.default_timezone = :utc
      Sequel::Model.plugin :timestamps, update_on_create: true
      Sequel::Model.plugin :active_model
    end

    config.active_job.queue_adapter = :sidekiq
  end
end
