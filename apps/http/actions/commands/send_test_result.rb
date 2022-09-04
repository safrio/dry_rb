# frozen_string_literal: true

require 'json'
require 'hanami/action'

module HTTP
  module Actions
    module Commands
      class SendTestResult < Hanami::Action
        include Dry::Monads[:result]

        include Import[
          command: 'contexts.cat_toy_testing.commands.send_test_result'
        ]

        def handle(req, res)
          result = command.call(
            testing_id: req.params[:testing_id]
          )

          case result
          in Success
            res.status  = 200
            res.body    = result.value!.to_json
          in Failure[_, error_message]
            halt 422, error_message.to_json
          end
        end
      end
    end
  end
end
