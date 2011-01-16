require 'ripl'
# 1.9 for now, though there is a very alpha 1.8 gem ...
require 'ripper'

module Ripl::Ripper
  def before_loop
    super
    @buffer = []
  end

  def prompt
    @buffer.empty? ? super : config[:ripper_prompt]
  end

  def loop_once
    catch(:multiline) do
      super
      @buffer = []
    end
  end

  def ripper_valid?(str)
    !!Ripper::SexpBuilder.new(str).parse
  end

  def eval_input(input)
    @buffer << input
    @input = @buffer.join("\n")
    ripper_valid?(@input) ? super(@input) : throw(:multiline)
  end
end

Ripl::Shell.include Ripl::Ripper
Ripl.config[:ripper_prompt] = ' > '
