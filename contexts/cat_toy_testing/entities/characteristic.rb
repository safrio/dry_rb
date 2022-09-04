module CatToyTesting
  module Entities
    class Characteristic < Dry::Struct
      transform_keys(&:to_sym)

      attribute :id, CatToyTesting::Types::Integer

      attribute :testing_id, CatToyTesting::Types::Integer
      attribute :caracteristic_type, CatToyTesting::Types::CharacteristicType
      attribute :value, CatToyTesting::Types::CharacteristicValue
      attribute :comment, CatToyTesting::Types::CharacteristicComment
      attribute :will_recommend, CatToyTesting::Types::CharacteristicWillRecommend
    end
  end
end
