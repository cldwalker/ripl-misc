require 'ripl'

module Ripl
  module Rspec
    def execute(*args, &block)
      result = super
      Ripl.start :binding => binding, :irbrc => false unless result
      result
    end
  end
end

Spec::Example::ExampleGroup.send :include, Ripl::Rspec

# Get errors to print before ripl starts
class Spec::Runner::Reporter
  alias_method :old_example_failed, :example_failed
  def example_failed(example, error)
    old_example_failed(example, error)
    puts "'#{@example_group.description} #{example.description}' FAILED", error
  end
end
