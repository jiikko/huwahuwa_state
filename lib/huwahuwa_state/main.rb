module HuwahuwaState
  class NotAcceptedUpdate < StandardError; end

  module Main
    extend ActiveSupport::Concern

    included do
      def self.huwahuwa_state(state_name = nil, column_name: nil, from: nil, options: [], &block)
        if state_name.nil?
          @@column_name = column_name || :name
          return
        end

        raise(ArgumentError, 'missing keyword: from') if from.nil?
        define_method "can_#{state_name}?" do |and_options: []| # can_hoge?が定義される
          valid_optionsed = true
          if options.present?
            valid_optionsed = and_options.map { |x| options.include?(x) }.any?
          end
          valid_state = from.map(&:to_s).include?(self.send(@@column_name))
          valid_state && valid_optionsed
        end
        self.class_variable_set("@@_block_#{state_name}", block)
      end
    end

    def update_state!(state_name, and_options: [])
      raise(NotAcceptedUpdate) unless send("can_#{state_name}?", and_options: and_options)
      self.class.class_variable_get("@@_block_#{state_name}").call(self)
    end
  end
end
