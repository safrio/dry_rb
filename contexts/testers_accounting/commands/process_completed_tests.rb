module TestersAccounting
  module Commands
    class ProcessCompletedTests
      include Dry::Monads[:result]
      include Dry::Monads::Do.for(:call)

      include Import[
        account_repo: 'contexts.testers_accounting.repositories.account',
        cat_toy_repo: 'contexts.testers_accounting.repositories.cat_toy',
        testing_repo: 'contexts.testers_accounting.repositories.testing',
      ]

      POINTS_COUNT = 1000

      def call(payload)
        yield validate_payload(payload)

        yield award_by_points(payload)

        Success(success: true)
      end

    private

      def validate_payload(payload)
        # ...

        Success(success: true)
      end

      def award_by_points(payload)
        # ...

        Success(success: true)
      end

    end
  end
end
