require 'ripl'
require 'eventmachine'

# Runs eventmachine code in a ripl shell - asynchronously of course
# TODO: Readline history, autocompletion and Ctrl-D exit
module Ripl::Em
  def self.included(mod)
    meth = mod.instance_method(:loop)
    mod.send(:define_method, :loop) do
      catch(:ripl_exit) {
        EM.run { meth.bind(Ripl.shell).call }
      }
    end
  end

  def get_input() @input end

  def before_loop
    $stdout.sync = true
    super
    trap("SIGINT") { handle_interrupt }
    EM.open_keyboard(KeyboardHandler)
  end
end

class KeyboardHandler < EM::Connection
  include EM::Protocols::LineText2

  def post_init
    print Ripl.shell.prompt
  end

  # TODO: #receive_data and autocompletion
  def xreceive_data(data)
    if data[/\t$/]
      warn "TAB #{data}"
      Bond.agent.call(data.chop, data.chop)
    else
      super
    end
  end

  def receive_line(line)
    # TODO: use accessor
    Ripl.shell.instance_variable_set :@input, line
    Ripl.shell.loop_once
    print Ripl.shell.prompt
  end
end

Ripl.config[:readline] = false
Ripl::Shell.include Ripl::Em
