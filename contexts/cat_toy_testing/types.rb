module CatToyTesting
  module Types
    include Dry.Types()

    # Types for account
    AccountName = String.optional
    AccountEmail = String.constrained(
      format: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    )
    AccountAddress = String

    # Types for caracteristics
    CharacteristicType = String.enum('happines' ,'playful', 'safeties', 'brightness')
    CharacteristicValue = String.constrained(format: /\A[0-9a-z]{8}\z/i)
    CharacteristicComment = String.optional
    CharacteristicWillRecommend = Bool

    # Types for toys
    CatToyTitle = String.constrained(min_size: 3)
    CatToyCharacteristic = Integer
    CatToyArchivedStatus = Bool.default(false)
  end
end
