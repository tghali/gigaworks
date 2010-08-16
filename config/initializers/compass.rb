require 'compass'
require 'compass/app_integration/rails'
Compass::AppIntegration::Rails.initialize!

Rails.application.config.middleware.delete Sass::Plugin::Rack