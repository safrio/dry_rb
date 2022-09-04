module InMemory
  module Transport
    class TestersAccountingRequest
      include Import[service: 'contexts.testers_accounting.commands.process_completed_tests']

      def call
        puts 'Hello from in_memory testers_accounting request'
        puts 'Call logic:'
        puts

        service.call(order: {status: 'payed', items: [title: 'qwe', count: 1]}, account_id: 1)

        puts
        puts 'Request done'
      end
    end
  end
end
