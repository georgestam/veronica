require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
require "attachinary/orm/active_record" #  Attachinary
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Veronica
  class Application < Rails::Application
      
    eval File.read(Rails.root.join('config', 'initializers', 'global_functions.rb'))
    
    def self.port
      if test?
        @@application_port ||= "5#{1000 + (Random.rand * 8999).to_i}".to_i
      elsif development?
        3000
      else
        nil
      end
    end
    
    def self.host
      if development? || test?
        'localhost'
      else
        "www.helloveronica.com"
      end
    end
    
    def self.protocol
      'http'
    end
    
    def self.main_locale
      :en
    end
    
    config.i18n.fallbacks = [main_locale]
    config.i18n.load_path += Dir[Rails.root.join('config/locales/**/*.yml').to_s]
    
    def self.set_url_options!
      [
        Rails.application.routes.default_url_options,
        Devise::Engine.routes.default_url_options
      ].each do |config|

        config[:host] = self.host
        config[:port] = self.port if self.port
        config[:protocol] = self.protocol
        config[:only_path] = false
         
      end
    end
    
    set_url_options!
    
  end
  
end


