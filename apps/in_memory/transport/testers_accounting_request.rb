module InMemory
  module Transport
    class TestersAccountingRequest
      include Import[service: 'contexts.testers_accounting.service']
      # include Import[service: 'contexts.matcher.service'] # Exeption example for cross context calls

      def call
        puts 'Hello from in_memory testers_accounting request'
        puts 'Call logic:'
        puts
        sleep 0.5

        service.call

        puts
        sleep 0.5
        puts 'Request done'
      end
    end
  end
end
