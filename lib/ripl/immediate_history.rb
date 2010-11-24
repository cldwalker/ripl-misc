module Ripl::ImmediateHistory
  # write to history after every eval
  def eval_input(input)
    super
    File.open(history_file, 'a') {|f| f.puts input }
  end

  # disable writing to history when ripl exits
  def write_history; end
end
Ripl::Shell.send :include, Ripl::ImmediateHistory
