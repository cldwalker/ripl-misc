require 'ripl'

module Ripl::Meta
  def ripl_methods_table(*args)
    Ripl::Meta.ripl_methods_table(*args)
  end

  def ripl_plugins(*args)
    Ripl::Meta.ripl_plugins(*args)
  end

  def self.ripl_plugins
    Ripl::Shell.ancestors - [Ripl::Shell, Ripl::Shell::API] - Object.ancestors
  end

  def self.ripl_shell_methods
    Ripl::Shell::API.instance_methods.delete_if {|e| e[/=$/]}.sort
  end

  # Prints Shell methods and the plugins that define that method (in the order
  # they are called)
  def self.ripl_methods_table(extras=false)
    return unless hirb_is_present?
    puts Hirb::Helpers::AutoTable.render(_ripl_methods_table(extras),
      :change_fields => [:method, :plugins])
  end

  def self._ripl_methods_table(extras)
    plugins = ripl_plugins
    extras = extras ? plugins.map(&:instance_methods).flatten : []
    (ripl_shell_methods + extras).uniq.inject({}) do |hash, meth|
      plugins.each {|e|
        (hash[meth] ||= []) << e if e.instance_methods.include?(meth)
      }
      hash
    end
  end

  def self.hirb_is_present?
    return true if defined? Hirb
    require 'hirb'
    true
  rescue LoadError
    warn "hirb is required for ripl_methods_table -> gem install hirb"
    false
  end
end

Ripl::Commands.include Ripl::Meta
