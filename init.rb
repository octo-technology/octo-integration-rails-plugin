require File.join(File.dirname(__FILE__), 'lib', 'octo')

ActionController::Base.send :include, OctoAuth

config.gem 'ruby-openid', :lib => false
config.gem 'authlogic'
config.gem 'authlogic-oid', :lib => 'authlogic_openid'
