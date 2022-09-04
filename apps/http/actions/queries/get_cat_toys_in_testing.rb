# frozen_string_literal: true

require 'json'
require 'hanami/action'

module HTTP
  module Actions
    module Queries
      class GetCatToysInTesting < Hanami::Action
        include Dry::Monads[:result]

        include Import[
          query: 'contexts.cat_toy_testing.queries.get_cat_toys_in_testing'
        ]

        def handle(req, res)
          result = query.call(account_id: req.session[:account_id])

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
