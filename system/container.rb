require 'dry/system/container'
require 'dry/system/container'
require "dry/system/loader/autoloading"
require "zeitwerk"

# General container class for project dependencies
#
# {http://dry-rb.org/gems/dry-system/ Dry-system documentation}
class Container < Dry::System::Container
  use :env, inferrer: -> { ENV.fetch('PROJECT_ENV', :development).to_sym }
  use :zeitwerk

  configure do |config|
    # libraries
    config.component_dirs.add 'lib' do |dir|
      dir.memoize = true
    end

    # business logic
    config.component_dirs.add 'contexts' do |dir|
      dir.memoize = true

      dir.namespaces.add 'cat_toy_testing', key: 'contexts.cat_toy_testing'
      dir.namespaces.add 'testers_accounting', key: 'contexts.testers_accounting'
    end

    # simple transport
    config.component_dirs.add 'apps' do |dir|
      dir.memoize = true

      dir.namespaces.add 'in_memory', key: 'in_memory'
    end
  end
end

Import = Container.injector
