class User < ActiveRecord::Base
  enum state: [:state_active, :state_freeze, :state_rock, :state_pending]
  huwahuwa_state column_name: :state

  huwahuwa_state :state_active, from: [:state_pending, :state_freeze, :state_pending] do |record|
    # some
    record.state_active!
    # some
  end

  huwahuwa_state :state_rock, from: [:state_active] do |record|
    record.state_rock!
  end

  huwahuwa_state :state_pending, from: [] do |record|
    # do nothing
  end
end
