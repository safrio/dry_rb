# frozen_string_literal: true

module Kafka
  module Consumers
    class Match #< ApplicationConsumer
      include Import[command: 'contexts.testers_accounting.commands.process_completed_tests']

      def consume
        command.call(order: messages.payloads[:payload][:order])
      end
    end
  end
end

