$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'pry'
require "active_record"
require 'huwahuwa_state'
require 'support/models/user'
require 'support/models/issue'

ActiveRecord::Base.establish_connection(
  adapter:   'sqlite3',
  database:  ':memory:'
)
ActiveRecord::Migrator.migrate(File.expand_path('../migrations', __FILE__))
