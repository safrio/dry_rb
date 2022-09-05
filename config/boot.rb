require "dotenv"
Dotenv.load(".env", ".env.#{ENV["PROJECT_ENV"]}")

require_relative '../system/container'
Container.finalize!
