$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'pry'
require "active_record"
require 'huwahuwa_state'

ActiveRecord::Base.establish_connection(
  adapter:   'sqlite3',
  database:  ':memory:'
)
ActiveRecord::Migrator.migrate(File.expand_path('../migrations', __FILE__))

class User < ActiveRecord::Base
  enum state: [:state_active, :state_freeze, :state_rock, :state_pending]
  huwahuwa_state column_name: :state

  hh_state :state_active, from: [:state_pending, :state_freeze, :state_pending] do |record|
    # some
    record.state_active!
    # some
  end

  hh_state :state_rock, from: [:state_active] do |record|
    record.state_rock!
  end

  hh_state :state_pending, from: [] do |record|
    # do nothing
  end

end
