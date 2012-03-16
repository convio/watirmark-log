require 'spec_helper'

context "Unit Tests for help method" do
  before :all do
    @log = WatirmarkLog::Logger.new
  end

  specify "help" do
    log_output = capture_stdout {
      @log.help
    }
    log_output.string.should == "\nInitializing a Watirmark Logger:\nlogger = WatirmarkLog::Loger.new('optional_logger_name')\n\nLogging methods:\nlogger.debug 'debug message' => 'DEBUG: debug message'\nlogger.info 'info message' => 'INFO: info message'\nlogger.warn 'warn message' => 'WARN: warn message'\nlogger.error 'error message' => 'ERROR: error message'\nlogger.turn_off = true => turns off all logging to stdout\n\nLogging Hierarchy (debug < info < warn < error):\nlog.level = :info\nlogger.debug 'this message will NOT execute'\nlogger.info 'info message'\nlogger.warn 'warn message'\nlogger.error 'this message will AlWAYS execute'\n\nLog Color Coding:\nlog.colors => {:black => :black, :red => :red,:green => :green, :yellow => :yellow, :blue => :blue, :magenta => :magenta, :cyan => :cyan, :white => :white}\nlog.debug_color = :red\nlog.debug 'debug message with color' => \e[31mDEBUG: debug message with color\e[0m\n      \nCreating Log File:\nCreate a file where all log information is streamed to.\nThis is not dependent on log.level\nEx.\nlog.create_file\nlog.create_file 'file_name.log'\nlog.create_file 'file_name.log', directory\n"
  end
end