module InMemory
  module Transport
    class CatToyTestingRequest
      include Import[
        assign_cat_toy: 'contexts.cat_toy_testing.commands.assign_cat_toy',
        get_cat_toys_in_testing: 'contexts.cat_toy_testing.queries.get_cat_toys_in_testing',
        send_test_result: 'contexts.cat_toy_testing.commands.send_test_result',
      ]

      def call
        puts 'Hello from in_memory cat_toy_testing request'
        puts 'Call logic:'
        puts

        res = get_cat_toys_in_testing.call(account_id: 1)
        puts "get_cat_toys_in_testing result: #{res}"

        res = assign_cat_toy.call(account_id: 1, cat_toy_id: 2)
        puts "assign_cat_toy result: #{res}"

        res = get_cat_toys_in_testing.call(account_id: 1)
        puts "get_cat_toys_in_testing 2 result: #{res}"

        res = send_test_result.call(testing_id: 1)
        puts "send_test_result result: #{res}"

        puts
        puts 'Requests done'
      end
    end
  end
end
