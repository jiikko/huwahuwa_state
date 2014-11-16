require "huwahuwa_state/version"
require 'huwahuwa_state/main'

::ActiveRecord::Base.send(:include, HuwahuwaState::Main)
