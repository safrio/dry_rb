module TestersAccounting
  module Entities
    class CatToy < Dry::Struct
      transform_keys(&:to_sym)

      attribute :id, TestersAccounting::Types::Integer

      attribute :title, TestersAccounting::Types::CatToyTitle
      attribute :characteristic, TestersAccounting::Types::CatToyCharacteristic
      attribute :archived, TestersAccounting::Types::CatToyArchivedStatus
    end
  end
end
