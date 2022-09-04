module CatToyTesting
  module Repositories
    class Characteristics
      include Import[db: 'persistance.db']

      def where_id_eq(id)
        db[:characteristics].select { |row| id == row[:id] }
          .map { |raw| CatToyTesting::Entities::Characteristic.new(raw) }
      end
    end
  end
end
