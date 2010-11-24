# equivalent to IRB.conf[:SAVE_HISTORY]
module Ripl::HistorySize
  def write_history
    if (limit = config[:history_size]) && limit >= 0
      saved_history = Array(history).reverse.slice(0, limit).reverse
      File.open(history_file, 'w') {|f| f.write saved_history.join("\n") }
    else
      super
    end
  end
end

Ripl::Shell.send :include, Ripl::HistorySize
