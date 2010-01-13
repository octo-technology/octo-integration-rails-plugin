require 'fileutils'

def sync_asset plugin_files, app_folder
  FileUtils.mkdir app_folder, :verbose => true unless File.exists? app_folder
  FileUtils.cp plugin_files, File.join(app_folder, ''), :verbose => true
end

current_path = File.dirname(__FILE__)

sync_asset Dir.glob(File.join(current_path, 'migrations', '*.rb')), File.join(RAILS_ROOT, 'db', 'migrate')
sync_asset Dir.glob(File.join(current_path, 'public', 'images', 'octo-rails', '*')), File.join(RAILS_ROOT, 'public', 'images', 'octo-rails')
sync_asset Dir.glob(File.join(current_path, 'public', 'sass_stylesheets', '*')), File.join(RAILS_ROOT, 'public', 'sass')


infos = <<EOF


====================================
Thank you for installing this plugin
To complete the installation, you must install manually the open_id_authentication plugin.

ruby ./script/plugin install git://github.com/rails/open_id_authentication.git

EOF

puts infos
