require 'ripl'

module Ripl::CustomErrors
  def print_eval_error(err)
    if handler = config[:custom_errors][err.class]
      handler.call(err)
    else
      super
    end
  end
end

Ripl::Shell.send :include, Ripl::CustomErrors
Ripl.config[:custom_errors] = {}
