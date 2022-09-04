module CatToyTesting
  module Entities
    class Testing < Dry::Struct
      transform_keys(&:to_sym)

      attribute :id, CatToyTesting::Types::Integer

      attribute :account_id, CatToyTesting::Types::Integer
      attribute :cat_toy_id, CatToyTesting::Types::Integer
      attribute :archived, CatToyTesting::Types::Bool
    end
  end
end
