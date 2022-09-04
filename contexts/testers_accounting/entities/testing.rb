module TestersAccounting
  module Entities
    class Testing < Dry::Struct
      transform_keys(&:to_sym)

      attribute :id, TestersAccounting::Types::Integer

      attribute :account_id, TestersAccounting::Types::Integer
      attribute :cat_toy_id, TestersAccounting::Types::Integer
      attribute :archived, TestersAccounting::Types::Bool
    end
  end
end
