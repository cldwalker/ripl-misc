require 'ripl'
require 'bacon'

# Usage: bacon -r ripl/bacon ...
# drops failing specs into ripl console
module Ripl
  module Bacon
    def self.included(mod)
      mod.module_eval %[
        alias_method :old_it, :it
        def it(description, &block)
          old_it(description) do
            begin
              yield
            rescue ::Bacon::Error
              Ripl.start :binding => binding, :irbrc => false
              raise
            end
          end
        end
      ]
    end
  end
end

Bacon::Context.send :include, Ripl::Bacon
