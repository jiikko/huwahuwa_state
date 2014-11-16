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
