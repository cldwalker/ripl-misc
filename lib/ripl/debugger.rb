require 'ripl'
# usage: require 'ripl/debugger'; debugger
module Kernel
  def debugger
    Ripl.start :binding => self.instance_eval { binding }, :irbrc => false
  end
end
