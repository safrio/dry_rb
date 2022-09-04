module CatToyTesting
  module Queries
    class GetCatToysInTesting
      include Dry::Monads[:result, :try, :maybe]
      include Dry::Monads::Do.for(:call)

      include Import[
        account_repo: 'contexts.cat_toy_testing.repositories.account',
        cat_toy_repo: 'contexts.cat_toy_testing.repositories.cat_toy',
        testing_repo: 'contexts.cat_toy_testing.repositories.testing',
      ]

      PayloadSchemaValidator = Dry::Schema.Params do
        required(:account_id).value(type?: Integer)
      end

      def call(payload)
        yield validate_payload(payload)

        account = yield find_account(payload[:account_id])
        testings_ids = yield find_testings(payload[:account_id])
        cat_toys = yield find_cat_toys_by_ids(testings_ids)

        Success(cat_toys: cat_toys)
      end

    private

      def validate_payload(payload)
        PayloadSchemaValidator.call(payload).to_monad
          .fmap { |result| result.to_h }
          .or   { |result| Failure([:invalid_payload, { error_message: result.errors.to_h, payload: payload }]) }
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
          testing_repo.all_active_by_account_id(account_id).map { |row| row[:id] }
        end.to_result.or(
          Failure([:testings_not_founded, { account_id: account_id }])
        )
      end

      def find_cat_toys_by_ids(ids)
        Maybe(cat_toy_repo.where_id_in(ids: ids))
          .or { |result| Failure([:cat_toys_not_found, { testings_ids: ids }]) }
      end
    end
  end
end
