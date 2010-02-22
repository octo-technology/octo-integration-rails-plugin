config.gem 'haml'
config.gem 'ruby-openid', :lib => false
config.gem 'rack-openid', :lib => 'rack/openid'
require 'openid'
require 'openid_ar_store'

require File.join(File.dirname(__FILE__), 'lib', 'openid_patch')

ActionController::Base.send :include, OctoRails

config.after_initialize do
  Haml.init_rails(binding) if defined?(Haml)
end
