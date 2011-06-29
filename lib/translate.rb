module Translate
  def self.locales_dir=(dir)
    @locales_dir = dir.to_s
  end

  def self.locales_dir
    @locales_dir || Rails.root.join("config", "locales").to_s
  end
end

require File.join(File.dirname(__FILE__), "translate_controller")
require File.join(File.dirname(__FILE__), "translate_helper")
Dir[File.join(File.dirname(__FILE__), "translate", "*.rb")].each do |file|
  require file
end

# TODO: Use new method available_locales once Rails is upgraded, see:
# http://github.com/svenfuchs/i18n/commit/411f8fe7c8f3f89e9b6b921fa62ed66cb92f3af4
# kill me......
def I18n.valid_locales
  I18n.backend.send(:init_translations) unless I18n.backend.initialized?
  backend.send(:translations).keys.reject { |locale| locale == :root }
end

