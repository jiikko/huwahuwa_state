module HuwahuwaState
  class NotAcceptedUpdate < StandardError; end

  module Main
    extend ActiveSupport::Concern

    included do
      def self.huwahuwa_state(column_name: nil)
        @@column_name = column_name || :name
      end

      def self.hh_state(state_name, from: , options: [], &block)
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

    def update_state!(state_name, options: [])
      raise(NotAcceptedUpdate) unless send("can_#{state_name}?", and_options: options)
      self.class.class_variable_get("@@_block_#{state_name}").call(self)
    end
  end
end