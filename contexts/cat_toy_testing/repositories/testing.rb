module CatToyTesting
  module Repositories
    class Testing
      include Import[db: 'persistance.db']

      def create(account_id:, cat_toy_id:)
        testing = map_to_entity({
                                 id: max_id + 1,
                                 account_id: account_id,
                                 cat_toy_id: cat_toy_id,
                                 archived: false
                               })
        db[:testings] << testing
        testing
      end

      def all_active_by_account_id(id)
        db[:testings].select { |row| row[:account_id] == id && row[:archived] == false }
          .map { |raw| map_to_entity(raw) }
      end

      def all_active_by_account_ids(ids)
        db[:testings].select { |row| ids.include?(row[:account_id]) && row[:archived] == false }
          .map { |raw| map_to_entity(raw) }
      end

      def select_by_id(id)
        db[:testings].select { |row| row[:id] == id && row[:archived] == false }
          .map { |raw| map_to_entity(raw) }
      end

    private

      def max_id
        (db[:testings].max_by {|r| r[:id] }&.dig(:id)).to_i
      end

      def map_to_entity(raw)
        CatToyTesting::Entities::Testing.new(raw)
      end
    end
  end
end
