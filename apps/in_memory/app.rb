require_relative '../../config/boot'

puts 'Loaded container:'
puts "container: #{Container}"
puts "container keys: #{Container.keys}"

puts
puts '*' * 40
puts

Container['in_memory.transport.cat_toy_testing_request'].call
puts
puts '*' * 40
puts
Container['in_memory.transport.testers_accounting_request'].call
