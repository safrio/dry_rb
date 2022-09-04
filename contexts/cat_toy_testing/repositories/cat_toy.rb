module CatToyTesting
  module Repositories
    class CatToy
      include Import[db: 'persistance.db']

      def where_id_in(ids:)
        db[:cat_toys].select { |row| ids.include?(row[:id]) && row[:archived] == false }
          .map { |raw_cat_toy| CatToyTesting::Entities::CatToy.new(raw_cat_toy) }
      end
    end
  end
end
