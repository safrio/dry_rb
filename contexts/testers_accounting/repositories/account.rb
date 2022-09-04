module TestersAccounting
  module Repositories
    class Account
      include Import[db: 'persistance.db']

      def find(id:)
        map_raw_result_to_entity(
          db[:accounts].select { |row| row[:id] == id }&.first
        )
      end

    private

      def map_raw_result_to_entity(raw_account)
        TestersAccounting::Entities::Account.new(raw_account)
      end
    end
  end
end
