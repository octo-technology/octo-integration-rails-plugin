require 'fileutils'
current_path = File.dirname(__FILE__)

migrations = Dir.glob(File.join(current_path, 'migrations', '*.rb'))
migrate_folder = File.join(RAILS_ROOT, 'db', 'migrate')
FileUtils.mkdir migrate_folder, :verbose => true unless File.exists? migrate_folder
FileUtils.cp migrations, File.join(migrate_folder, ''), :verbose => true

images = Dir.glob(File.join(current_path, 'public', 'images', 'octo-rails', '*'))
images_folder = File.join(RAILS_ROOT, 'public', 'images', 'octo-rails')
FileUtils.mkdir images_folder, :verbose => true unless File.exists? images_folder
FileUtils.cp images, File.join(images_folder, ''), :verbose => true

infos = <<EOF


====================================
Thank you for installing this plugin
To complete the installation, you must install manually the open_id_authentication plugin.

ruby ./script/plugin install git://github.com/rails/open_id_authentication.git

EOF

puts infos
