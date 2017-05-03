require('rspec')
require('list')
require('pg')
require('task')

# DB = PG.connect({:dbname=>'to_do_test', :user=>'postgres', :password=>311938})

DB = PG.connect({:dbname=>'to_do_test'})

RSpec.configure do |config|
  config.before(:each) do
    DB.exec("DELETE FROM tasks *;")
    DB.exec("DELETE FROM lists *;")
  end
end
