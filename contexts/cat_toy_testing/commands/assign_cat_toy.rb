module CatToyTesting
  module Commands
    class AssignCatToy
      include Dry::Monads[:result, :try]
      include Dry::Monads::Do.for(:call)

      include Import[
        account_repo: 'contexts.cat_toy_testing.repositories.account',
        testing_repo: 'contexts.cat_toy_testing.repositories.testing',
      ]

      TestingSchemaValidator = Dry::Schema.Params do
        required(:testings).value(max_size?: 3)
      end

      PayloadSchemaValidator = Dry::Schema.Params do
        required(:account_id).value(type?: Integer)
        required(:cat_toy_id).value(type?: Integer)
      end

      def call(payload)
        yield validate_payload(payload)

        account = yield find_account(payload[:account_id])
        testings = yield find_testings(payload[:account_id])
        yield validate_testing(testings)

        result = testing_repo.create(account_id: payload[:account_id], cat_toy_id: payload[:cat_toy_id])

        Success(result: result)
      end

    private

      def validate_payload(payload)
        PayloadSchemaValidator.call(payload).to_monad
          .fmap { |result| result.to_h }
          .or   { |result| Failure([:invalid_payload, { error_message: result.errors.to_h, payload: payload }]) }
      end

      def validate_testing(testing)
        TestingSchemaValidator.call(testings: testing).to_monad
          .fmap { |result| result.to_h }
          .or   { |result| Failure([:invalid_testing, { error_message: result.errors.to_h, testing: testing }]) }
      end

      def find_account(account_id)
        Try[Dry::Struct::Error] do
          account_repo.find(id: account_id)
        end.to_result.or(
          Failure([:account_not_founded, { account_id: account_id }])
        )
      end

      def find_testings(account_id)
        Try[Dry::Struct::Error] do
          testing_repo.all_active_by_account_id(account_id)
        end.to_result.or(
          Failure([:testings_not_founded, { account_id: account_id }])
        )
      end
    end
  end
end
