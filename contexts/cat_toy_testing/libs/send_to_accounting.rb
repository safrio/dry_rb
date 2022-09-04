module CatToyTesting
  module Libs
    class SendToAccounting
      include Dry::Monads[:result]


      def call(payload)
        # ...

        Success(success: true)
      end
    end
  end
end
