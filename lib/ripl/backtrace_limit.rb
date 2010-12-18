require 'ripl'

module Ripl::BacktraceLimit
  def format_error(err)
    stack = err.backtrace.slice(0, config[:backtrace_limit])
    "#{err.class}: #{err.message}\n    #{stack.join("\n    ")}"
  end
end

Ripl::Shell.send :include, Ripl::BacktraceLimit
Ripl.config[:backtrace_limit] = 16
