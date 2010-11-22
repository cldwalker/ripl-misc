module Ripl::Options
  def options
    @options ||= super << ['-p FILE', 'Require plugin'] <<
      ['-e ARGS', 'Loads irbrc, executes ruby and quits'] <<
      ['-l, --local', 'Loads local libraries from lib/'] 
  end

  def invalid_option(option, argv)
    case option
    when /-p=?(.*)/
      require "ripl/" + ($1.empty? ? argv.shift.to_s : $1)
    when '-e'
      Ripl.shell.before_loop
      Ripl.shell.loop_eval(argv.join(" "))
      exit
    when '-l', '--local'
      $:.unshift 'lib'
      Dir['lib/*.rb'].each {|e| require File.basename(e) }
    else
      super
    end
  end
end
Ripl::Runner.extend Ripl::Options
