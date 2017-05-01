require('rspec')
require('todo')
require('pg')

DB = PG.connect({:dbname=>'to_do_test', :user=>'postgres', :password=>311938})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM tasks *;")
    DB.exec("DELETE FROM lists *;")
  end
end
