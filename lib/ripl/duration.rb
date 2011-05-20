require 'ripl'

# 1.9 only, prints duration of ripl session in a human friendly way
module Ripl::Duration
  def before_loop
    Ripl::Duration.start_time = Time.now
    super
  end

  def after_loop
    super
    puts "", "ripl session lasted for " +
      Ripl::Duration.format((Time.now - Ripl::Duration.start_time).to_i)
  end

  class << self
    UNITS = { week: 604800, day: 86400, hour: 3600, minute: 60, second: 1 }
    attr_accessor :start_time

    # inspired by duration gem
    def format(seconds)
      UNITS.inject([]) do |acc, (k,v)|
        if (unit_num = seconds / v) > 0
          acc << "#{unit_num} #{k}#{unit_num == 1 ? '' : 's'}"
          seconds -= unit_num * v
        end
        acc
      end.join(', ')
    end
  end
end

Ripl::Shell.include Ripl::Duration
