require "huwahuwa_state/version"
require 'huwahuwa_state/main'

if defined?(Rails)
  class Railtie < Rails::Railtie
    initializer 'initialize huwahuwa_state' do
      ActiveSupport.on_load(:active_record) do
        ::ActiveRecord::Base.send(:include, HuwahuwaState::Main)
      end
    end
  end
else
  ::ActiveRecord::Base.send(:include, HuwahuwaState::Main)
end
