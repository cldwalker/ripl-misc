require 'ripl'
require 'hirb'

module Ripl::Page
  def before_loop
    super
    Hirb.enable(:formatter=>false)
  end

  def format_result(result)
    Hirb::View.page_output(result_prompt + result.inspect, true) || super
  end
end

Ripl::Shell.send :include, Ripl::Page
