require 'ripl'

module Ripl::Echo
  def print_result(*)
    super if config[:echo]
  end
end

Ripl::Shell.send :include, Ripl::Echo
Ripl.config[:echo] = true
