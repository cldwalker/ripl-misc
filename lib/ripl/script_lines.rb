require 'ripl'

module Ripl::ScriptLines
  def before_loop
    Object.const_set :SCRIPT_LINES__ , {}
    super
  end

  module Commands
    def stats 
      puts "You have #{SCRIPT_LINES__.keys.size} files and " +
        "#{SCRIPT_LINES__.values.flatten.size} lines"
    end
  end
end

Ripl::Shell.include Ripl::ScriptLines
Ripl::Commands.include Ripl::ScriptLines::Commands
