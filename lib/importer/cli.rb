# Copyright (c) 2016 Tallwave

require "optparse"
require "importer"

module TrelloImporter
  module CLI

    def run
      begin
        OptionParser.new do |opts|
          opts.on("-h", "--help") do
            puts usage
            exit
          end

          opts.on("--version") do
            puts about
            exit
          end

        end.parse!
      rescue OptionParser::ParseError => e
        raise UsageError, e
      end

      fail UsageError, "missing argument" if ARGV.empty?
      fail UsageError, "incorrect number of arguments" unless correct_number_of_args ARGV.count
      ARGV.each_with_index { |arg, index| process_input arg, index }
      perform_action()

    rescue UsageError => e
      puts "#{$PROGRAM_NAME}: #{e}\nTry `#{$PROGRAM_NAME} --help` for more information."
      exit false
    end
  end
end
