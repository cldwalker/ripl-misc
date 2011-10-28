require 'ripl/shell'
require 'fileutils'

# Usage: ripl -rripl/tagger --file FILE
# Processes lines in a file, expecting user to tag each one
module Ripl::Tagger
  class << self; attr_accessor :line_number, :file, :dir;  end
  self.dir = 'tagger'
  self.line_number = 0

  def self.lines
    @lines ||= File.readlines(file).map(&:chomp)
  end

  def self.current_line
    lines[line_number]
  end

  def self.add_tags(tags)
    tags.split(/\s+/).each {|tag| add_tag(tag) }
  end

  def self.add_tag(tag)
    File.open("#{dir}/#{tag}.txt", 'a+') {|f|
      f.write current_line + "\n"
    }
  end

  def before_loop
    super
    FileUtils.mkdir_p Ripl::Tagger.dir
  end

  # purposefully do nothing
  def print_result(result) end
  def after_loop() end

  def eval_input(input)
    Ripl::Tagger.add_tags(input)
    Ripl::Tagger.line_number += 1
    @line += 1
    @result = ''
  end

  module Runner
    def parse_option(name, argv)
      if name == '--file'
        abort "File does not exist" unless File.exists?(File.expand_path(argv[0]))
        Ripl::Tagger.file = argv.shift
      else
        super
      end
    end
  end
end

Ripl::Shell.include Ripl::Tagger
Ripl::Runner.extend Ripl::Tagger::Runner
Ripl.config[:prompt] = -> {
 "\nLine #{Ripl.shell.line}:  #{Ripl::Tagger.current_line}\nWhat should this be tagged? "
}
