module TestersAccounting
  module Entities
    class Account < Dry::Struct
      transform_keys(&:to_sym)

      attribute :id, TestersAccounting::Types::Integer

      attribute? :name, TestersAccounting::Types::AccountName
      attribute :email, TestersAccounting::Types::AccountEmail
      attribute :address, TestersAccounting::Types::AccountAddress
    end
  end
end
