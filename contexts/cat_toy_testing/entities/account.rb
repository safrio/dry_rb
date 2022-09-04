module CatToyTesting
  module Entities
    class Account < Dry::Struct
      transform_keys(&:to_sym)

      attribute :id, CatToyTesting::Types::Integer

      attribute? :name, CatToyTesting::Types::AccountName
      attribute :email, CatToyTesting::Types::AccountEmail
      attribute :address, CatToyTesting::Types::AccountAddress
    end
  end
end
