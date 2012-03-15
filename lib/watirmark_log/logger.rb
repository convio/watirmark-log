module WatirmarkLog
  class Logger < LoggerBase
    attr_accessor :name,
                  :level,
                  :turn_off,

                  :log_file,
                  :log_file_destination,

                  :spec_report_file,

                  :debug_color,
                  :info_color,
                  :warn_color,
                  :error_color

    def initialize(name="WatirmarkLog")
      @level = WatirmarkLog::Level::DEBUG
      @turn_off = false
      @name = name

      @file_name = "#{@name.gsub(" ", "")}.log"
      @file_destination = Dir.pwd
      @log_file = nil
      create_report

      @debug_color = colors[:white]
      @info_color = colors[:white]
      @warn_color = colors[:white]
      @error_color = colors[:white]
      @fatal_color = colors[:white]
      @unknown_color = colors[:white]
    end

    # creates a file that will stream all log information to
    # file_name must be of type .log and only contain characters, digits, and underscores
    # file_name is @name.log by defualt
    # dir is the current working directory by debug
    def create_file file_name=@file_name, dir=Dir.pwd
      @file_name = file_name
      @file_destination = dir
      if valid_file_name
        if File.directory? @file_destination
          @log_file = File.open(@file_destination + "/" + @file_name, 'w')
          @log_file.puts "WatirmarkLog: " + inspect
        else
          raise ArgumentError, "Directory '#{@file_destination}' does not exist"
        end
      else
        raise ArgumentError, "File name: '#{@file_name}' must only contain characters, digits, and underscores, and must be of type .log"
      end
    end

    # top level debug method
    # writes debug message to stdout if level <= debug_level
    # trys to stream debug message to log_file and report_file
    # @log.debug "this is a debug message from #{@log.inspect}"
    def debug message
      super message
      output_to_file "DEBUG: " + message if @log_file
      output_to_report_file "DEBUG: " + message if @spec_report_file
    end

    # top level info method
    # writes info message to stdout if level <= info_level
    # trys to stream info message to log_file and report_file
    # @log.info "this is an info message from #{@log.inspect}"
    def info message
      super message
      output_to_file "INFO: " + message if @log_file
      output_to_report_file "INFO: " + message if @spec_report_file
    end

    # top level warn method
    # writes warn message to stdout if level <= warn_level
    # trys to stream warn message to log_file and report_file
    # @log.warn "this is a warn message from #{@log.inspect}"
    def warn message
      super message
      output_to_file "WARN: " + message if @log_file
      output_to_report_file "WARN: " + message if @spec_report_file
    end

    # top level error method
    # writes error message to stdout no matter what
    # trys to stream error message to log_file and report_file
    # @log.error "this is an error message from #{@log.inspect}"
    def error message
      super message
      output_to_file "ERROR: " + message if @log_file
      output_to_report_file "ERROR: " + message if @spec_report_file
    end

    def fatal message
      super message
      output_to_file "FATAL: " + message if @log_file
      output_to_report_file "FATAL: " + message if @spec_report_file
    end

    def unknown message
      super message
      output_to_file "UNKNOWN: " + message if @log_file
      output_to_report_file "UNKNOWN: " + message if @spec_report_file
    end

    # returns the name of the Watirmark Logger
    # @log.debug "This is a debug message from #{@log.inspect}"
    def inspect
      @name
    end

    # returns a hash containing all valid colors in WatirmrkLog
    # @log.debug_color = @log.colors[:red]
    def colors
      {:black => :black, :red => :red, :green => :green, :yellow => :yellow, :blue => :blue, :magenta => :magenta, :cyan => :cyan, :white => :white}
    end

    # prints out help full tips on using WatirmarkLog
    def help
      log_tips = "\nInitializing a Watirmark Logger:
logger = WatirmarkLog::Loger.new('optional_logger_name')\n
Logging methods:
logger.debug 'debug message' => 'DEBUG: debug message'
logger.info 'info message' => 'INFO: info message'
logger.warn 'warn message' => 'WARN: warn message'
logger.error 'error message' => 'ERROR: error message'
logger.turn_off = true => turns off all logging to stdout\n
Logging Hierarchy (debug < info < warn < error):
log.level = :info
logger.debug 'this message will NOT execute'
logger.info 'info message'
logger.warn 'warn message'
logger.error 'this message will AlWAYS execute'\n
Log Color Coding:
log.colors => {:black => :black, :red => :red,:green => :green, :yellow => :yellow, :blue => :blue, :magenta => :magenta, :cyan => :cyan, :white => :white}
log.debug_color = :red
log.debug 'debug message with color' => " + "DEBUG: debug message with color".red + "
      \nCreating Log File:
Create a file where all log information is streamed to.
This is not dependent on log.level
Ex.
log.create_file
log.create_file 'file_name.log'
log.create_file 'file_name.log', directory"
      puts log_tips
    end
  end
end