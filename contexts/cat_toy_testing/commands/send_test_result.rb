module CatToyTesting
  module Commands
    class SendTestResult
      include Dry::Monads[:result]
      include Dry::Monads::Do.for(:call)

      include Import[
        characteristics_repo: 'contexts.cat_toy_testing.repositories.characteristics',
        testing_repo: 'contexts.cat_toy_testing.repositories.testing',
        send_to_accounting: 'contexts.cat_toy_testing.libs.send_to_accounting',
      ]

      PayloadSchemaValidator = Dry::Schema.Params do
        required(:testing_id).value(type?: Integer)
      end

      def call(payload)
        yield validate_payload(payload)

        characteristics = yield find_characteristics(payload[:testing_id])
        testings = yield find_testings(characteristics)
        cat_toys = yield find_cat_toys(testings)

        yield validate_output(cat_toys: cat_toys, characteristics: characteristics)

        result_obj = yield create_result_obj(testings: testings, characteristics: characteristics)
        yield send_to_accounting.call(result_obj)

        Success(success: true)
      end

    private

      def validate_payload(payload)
        PayloadSchemaValidator.call(payload).to_monad
          .fmap { |result| result.to_h }
          .or   { |result| Failure([:invalid_payload, { error_message: result.errors.to_h, payload: payload }]) }
      end

      def find_characteristics(testing_id)
        characteristics = characteristics_repo.where_id_eq(testing_id)

        if characteristics
          Success(characteristics)
        else
          Failure([:characteristics_not_founded, { testing_id: testing_id, characteristics: characteristics}])
        end
      end

      def find_testings(characteristics)
        char_ids = characteristics.map { |c| c[:id] }
        testings = testing_repo.all_active_by_account_ids(char_ids)

        if testings
          Success(testings)
        else
          Failure([:testings_not_founded, { characteristics: characteristics, testings: testings}])
        end
      end

      def find_cat_toys(testings)
        # ...

        Success([])
      end

      def create_result_obj(testings:, characteristics:)
        # ...

        Success({
          account_id: 1,
          cat_toy_id: 1,
          characteristics: [
            {
              caracteristic_type: 'happines',
              value: 'string12',
              comment: '',
              will_recommend: true
            },
          ]
        })
      end

      def validate_output(cat_toys:, characteristics:)
        # ...

        Success(:success)
      end

    end
  end
end
