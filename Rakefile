task :test do
  ruby 'tests/test.rb'
end

namespace :db do

  desc 'Create Database'
  task :create do
    puts "\nCreating database..."
    stdout = %x{createdb agora}
    puts stdout
  end

  desc 'Drop Database'
  task :drop do
    puts "\nDropping database..."
    stdout = %x{dropdb agora}
    puts stdout
  end

end
