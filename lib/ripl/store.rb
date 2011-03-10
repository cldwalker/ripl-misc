require 'ripl'
require 'fileutils'

# stores all local variables in a marshal dump to be restored in another ripl console
# simply start ripl both times with `ripl -rripl/store`
module Ripl::Store
  Store = self
  def self.marshal_file
    @marshal_file ||= begin
      path = File.expand_path('~/.ripl')
      FileUtils.mkdir_p path
      path + '/store.marshal'
    end
  end

  def before_loop
    Commands.restore if Time.now - File.mtime(Store.marshal_file) < 60
    super
  end

  def after_loop
    Commands.store
    super
  end

  module Commands
    extend self
    def store
      vals = Ripl.shell.loop_eval("local_variables.inject({}) {|h,e| h.update e => eval(e) }.delete_if {|k,v| k == '_' }")
      File.open(Store.marshal_file, 'wb') {|f| f.write Marshal.dump(vals) }
      vals
    end

    def restore
      store_hash.each {|k,v|
        Ripl.shell.loop_eval("#{k} = Ripl::Store::Commands.store_hash[#{k.inspect}]")
      }
    end

    def store_hash
      @store_hash ||= File.open(Store.marshal_file, 'rb'){|f| Marshal.load(f.read) }
    end
  end
end
Ripl::Shell.include Ripl::Store
Ripl::Commands.include Ripl::Store::Commands
