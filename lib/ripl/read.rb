require 'ripl'
require 'fileutils'

# store specific objects across ripl/irb/whatever sessions
module Ripl::Read
  Read = self
  def self.marshal_file
    @marshal_file ||= begin
      path = File.expand_path('~/.ripl')
      FileUtils.mkdir_p path
      path + '/read.marshal'
    end
  end

  module Commands
    def self.read_hash
      File.exists?(Read.marshal_file) ?
        File.open(Read.marshal_file, 'rb'){|f| Marshal.load(f.read) } : {}
    end

    def read(key)
      Commands.read_hash[key]
    end

    def write(key, val)
      new_val = Commands.read_hash.merge! key => val
      File.open(Read.marshal_file, 'wb') {|f| f.write Marshal.dump(new_val) }
    end
  end
end
Ripl::Commands.include Ripl::Read::Commands
