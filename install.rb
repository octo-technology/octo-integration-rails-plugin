require 'fileutils'
migrations = Dir.glob(File.join(File.dirname(__FILE__), 'migrations', '*.rb'))
migrate_folder = File.join(File.dirname(__FILE__), '..', '..', '..', 'db', 'migrate')
dest = File.join(migrate_folder, '')
FileUtils.mkdir migrate_folder, :verbose => true unless File.exists? migrate_folder
FileUtils.cp migrations, dest, :verbose => true
puts "run script/plugin install git://github.com/rails/open_id_authentication.git"
