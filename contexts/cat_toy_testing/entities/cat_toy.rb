module CatToyTesting
  module Entities
    class CatToy < Dry::Struct
      transform_keys(&:to_sym)

      attribute :id, CatToyTesting::Types::Integer

      attribute :title, CatToyTesting::Types::CatToyTitle
      attribute :characteristic, CatToyTesting::Types::CatToyCharacteristic
      attribute :archived, CatToyTesting::Types::CatToyArchivedStatus
    end
  end
end
