require 'mathn'

module Ripl
  module Math
    def format_result(result)
      result_prompt + result.to_s
    end
  end
end

Ripl::Commands.send :include, Math
