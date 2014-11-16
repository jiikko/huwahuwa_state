$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'pry'
require "active_record"
require 'huwahuwa_state'

ActiveRecord::Base.establish_connection(
  adapter:   'sqlite3',
  database:  ':memory:'
)
ActiveRecord::Migrator.migrate(File.expand_path('../migrations', __FILE__))


class Issue < ActiveRecord::Base
  enum state: [:untouched, :working, :pending_review, :resolved, :finished]
  huwahuwa_state column_name: :state

  hh_state :working, from: [:untouched, :pending_review, :resolved], options: [:worker] do |record|
    record.working!
  end

  hh_state :finished, from: [:resolved], options: [:manger] do |record|
    record.finished!
  end
end
