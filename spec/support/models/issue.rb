class Issue < ActiveRecord::Base
  enum state: [:untouched, :working, :pending_review, :resolved, :finished]
  huwahuwa_state column_name: :state

  huwahuwa_state :working, from: [:untouched, :pending_review, :resolved], options: [:worker] do |record|
    record.working!
  end

  huwahuwa_state :finished, from: [:resolved], options: [:manager] do |record|
    record.finished!
  end
end
