def sync_asset plugin_files, app_folder
  FileUtils.mkdir app_folder, :verbose => true unless File.exists? app_folder
  FileUtils.cp plugin_files, File.join(app_folder, ''), :verbose => true
end

current_path = File.dirname(__FILE__)

sync_asset Dir.glob(File.join(current_path, 'db', 'migrations', '*.rb')), File.join(RAILS_ROOT, 'db', 'migrate')
sync_asset Dir.glob(File.join(current_path, 'initializers', '*.rb')), File.join(RAILS_ROOT, 'config', 'initializers')
sync_asset Dir.glob(File.join(current_path, 'public', 'images', '*')), File.join(RAILS_ROOT, 'public', 'images')
sync_asset Dir.glob(File.join(current_path, 'public', 'sass', '*')), File.join(RAILS_ROOT, 'public', 'stylesheets', 'sass')
