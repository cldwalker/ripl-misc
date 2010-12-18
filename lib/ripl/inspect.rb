require 'ripl'

module Ripl::Inspect
  def format_result(result)
    config[:inspect] ? super : result_prompt + result.to_s
  end
end

Ripl::Shell.send :include, Ripl::Inspect
Ripl.config[:inspect] = true
