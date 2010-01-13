require File.join(File.dirname(__FILE__), 'lib', 'octo')

ActionController::Base.send :include, OctoAuth

config.gem 'ruby-openid', :lib => false
config.gem 'authlogic'
config.gem 'authlogic-oid', :lib => 'authlogic_openid'
config.gem 'haml'

config.after_initialize do
  Haml.init_rails(binding) if defined?(Haml)
  I18n.load_path << Dir[ File.join(File.dirname(__FILE__), 'config', 'locales', '*.{rb,yml}') ] 
end
