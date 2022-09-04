# frozen_string_literal: true

require "bundler/setup"
require "hanami/api"
require "hanami/middleware/body_parser"
require 'hanami/action'

module HTTP
  class App < Hanami::API
    use Hanami::Middleware::BodyParser, :json

    get '/get_cat_toys_in_testing', to: Container['http.actions.queries.get_cat_toys_in_testing']

    post '/assign_cat_toy', to: Container['http.actions.commands.assign_cat_toy']
    post '/send_test_result', to: Container['http.actions.commands.send_test_result']
  end
end
