# usage: require 'ripl/debugger'; debugger
module Kernel
  def debugger
    Ripl.start :binding => self.instance_eval { binding }
  end
end
