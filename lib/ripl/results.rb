require 'ripl'

# Access results with Ripl.shell.results, similar to IRB.conf[:EVAL_HISTORY]
module Ripl::Results
  attr_accessor :results

  def before_loop
    super
    @results = []
  end

  def eval_input(input)
    super
    @results << @result
  end
end

Ripl::Shell.include Ripl::Results
