require 'ripl'

# Positive reinforcement for the occassional error
# Mac only
module Ripl::Dozens
  def print_eval_error(err)
    super
    msg = config[:dozens][rand(config[:dozens].size)].gsub('`', '').gsub('"', '\"')
    system %[say -v #{config[:dozens_voice]} "#{msg}" &]
  end
end

Ripl::Shell.include Ripl::Dozens
Ripl.config[:dozens_voice] = 'Alex'
Ripl.config[:dozens] = [
  'What the fuck man?',
  'And boom',
  'And I pull out my gun',
  'Youz a piece of shit'
]

