module InMemory
  module Transport
    class CatToyTestingRequest
      include Import[service: 'contexts.cat_toy_testing.service']

      def call
        puts 'Hello from in_memory cat_toy_testing request'
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
