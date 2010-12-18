require 'ripl'

module Ripl::IgnoreSigint
  def handle_interrupt
    config[:ignore_sigint] ? super : throw(:ripl_exit)
  end
end

Ripl::Shell.send :include, Ripl::IgnoreSigint
Ripl.config[:ignore_sigint] = true
