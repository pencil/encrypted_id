$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'encrypted_id'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  c = ActiveRecord::Base.establish_connection(
    adapter: 'sqlite3',
    database: 'spec/test.sqlite3'
  )
  ActiveRecord::Base.connection.execute("DROP TABLE IF EXISTS 'users'")
  ActiveRecord::Base.connection.create_table(:users) do |t|
    t.timestamps
  end
end
