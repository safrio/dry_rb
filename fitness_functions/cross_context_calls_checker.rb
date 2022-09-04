require 'parser/current'

module FitnessFunctions
  class ParseFileDependencies
    def call(file_path)
      file = File.read("#{__dir__}/../#{file_path}")

      node = Parser::CurrentRuby.parse(file).loc.node
      find_dependencies(node.to_sexp_array)
    end

  private

    def select_include_nodes(sexp)
      sexp.select { |node| node[0] == :send && node[1] == nil && node[2] == :include }
    end

    def select_di_import_node(import_sexps)
      import_sexps.select { |node| Array(node[3][1])[2] == :Import }
    end

    def get_imported_dependencies(import_sexps)
      import_sexps.empty? ? [] : import_sexps.flat_map { |sexp| sexp[3][3][1..-1].map{ |n| n[2][1] } }
    end

    def find_dependencies(sexp)
      di_imports = []

      loop do
        sexp = sexp.pop

        if sexp[0] == :begin
          di_imports = get_imported_dependencies(
            select_di_import_node(
              select_include_nodes(sexp)
            )
          )
          break
        else
          next
        end
      end

      di_imports
    end
  end

  class CrossContextCallsChecker
    def call(file_path, whitelist: [])
      di_imports = ParseFileDependencies.new.call(file_path)

      puts "Checking: '#{file_path}'"
      puts "Dependencies for file: #{di_imports}"

      di_imports.each do |dependency|
        next if dependency.start_with?(*whitelist)

        raise "Invalid dependency '#{dependency}' for '#{file_path}'"
      end
    end
  end
end

# =========================================

puts
puts

whitelist = %w[
  contexts.cat_toy_testing.commands.assign_cat_toy
  contexts.cat_toy_testing.queries.get_cat_toys_in_testing
  contexts.cat_toy_testing.commands.send_test_result
]

file_path = 'apps/in_memory/transport/cat_toy_testing_request.rb'
FitnessFunctions::CrossContextCallsChecker.new.call(file_path, whitelist: whitelist)

puts
puts '****'
puts

whitelist = %w[
  contexts.testers_accounting.commands.process_completed_tests
]

file_path = 'apps/in_memory/transport/testers_accounting_request.rb'
FitnessFunctions::CrossContextCallsChecker.new.call(file_path, whitelist: whitelist)

puts
puts '****'
puts

whitelist = %w[
  contexts.cat_toy_testing.repositories.account
  contexts.cat_toy_testing.repositories.testing
]

file_path = 'contexts/cat_toy_testing/commands/assign_cat_toy.rb'
FitnessFunctions::CrossContextCallsChecker.new.call(file_path, whitelist: whitelist)


puts
puts '****'
puts

whitelist = %w[
  contexts.cat_toy_testing.repositories.characteristics
  contexts.cat_toy_testing.repositories.testing
  contexts.cat_toy_testing.libs.send_to_accounting
]

file_path = 'contexts/cat_toy_testing/commands/send_test_result.rb'
FitnessFunctions::CrossContextCallsChecker.new.call(file_path, whitelist: whitelist)

puts
puts '****'
puts

whitelist = %w[
  contexts.cat_toy_testing.repositories.account
  contexts.cat_toy_testing.repositories.cat_toy
  contexts.cat_toy_testing.repositories.testing
]

file_path = 'contexts/cat_toy_testing/queries/get_cat_toys_in_testing.rb'
FitnessFunctions::CrossContextCallsChecker.new.call(file_path, whitelist: whitelist)


puts
puts '****'
puts

whitelist = %w[
  persistance.db
]

%w[account cat_toy characteristics testing].each do |file_name|
  file_path = "contexts/cat_toy_testing/repositories/#{file_name}.rb"
  FitnessFunctions::CrossContextCallsChecker.new.call(file_path, whitelist: whitelist)
end

puts
puts '****'
puts

whitelist = %w[
  contexts.testers_accounting.repositories.account
  contexts.testers_accounting.repositories.cat_toy
  contexts.testers_accounting.repositories.testing
]

file_path = 'contexts/testers_accounting/commands/process_completed_tests.rb'
FitnessFunctions::CrossContextCallsChecker.new.call(file_path, whitelist: whitelist)


puts
puts '****'
puts

whitelist = %w[
  persistance.db
]

%w[account cat_toy testing].each do |file_name|
  file_path = "contexts/testers_accounting/repositories/#{file_name}.rb"
  FitnessFunctions::CrossContextCallsChecker.new.call(file_path, whitelist: whitelist)
end


# [:send, [:const, nil, :Import],
# binding.irb
# :end
