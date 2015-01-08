# HuwahuwaState - Ruby simple state machines
using ActiveRecord::Enum.

## Installation

Add this line to your application's Gemfile:

    gem 'huwahuwa_state', github: 'jiikko/huwahuwa_state'


And then execute:

    $ bundle

## Requirements
-  "activerecord", ">= 4.1"

## Example
```ruby
class User < ActiveRecord::Base
  enum state: [:state_active, :state_freeze, :state_rock, :state_pending]
  huwahuwa_state column_name: :state
  
  huwahuwa_state :state_active, from: [:state_pending, :state_freeze, :state_pending] do |record|
    # something
    record.state_active!
    # something
  end

  huwahuwa_state :state_rock, from: [:state_active] do |record|
    record.state_rock!
  end
end
```

```ruby
# success
user = User.create(state: User.states["state_pending"])
user.update_state!(:state_active)
user.can_state_active? # => true
user.state # => 'state_active'

# failure
user = User.create(state: User.states["state_freeze"])
user.can_state_rock? # => false
user.update_state!(:state_rock) # => HuwahuwaState::NotAcceptedUpdate
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/huwahuwa_state/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
