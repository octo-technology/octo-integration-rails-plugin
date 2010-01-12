require 'fileutils'
migrations = Dir.glob(File.join(File.dirname(__FILE__), 'migrations', '*.rb'))
dest = File.join(File.dirname(__FILE__), '..', '..', '..', 'db', 'migrate', '')
FileUtils.cp migrations, dest, :verbose => true
puts "run script/plugin install git://github.com/rails/open_id_authentication.git"
