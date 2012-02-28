module WatirmarkLog
  class LoggerBase

    # builds debug message and executes output_message if valid_conditions are met
    def debug message
      message = "DEBUG: " + message
      output_message message, @debug_color if valid_conditions 0
    end

    # builds info message and executes output_message if conditions are met
    def info message
      message = "INFO: " + message
      output_message message, @info_color if valid_conditions 1
    end

    # builds info message and executes output_message if conditions are met
    def warn message
      message = "WARN: " + message
      output_message message, @warn_color if valid_conditions 2
    end

    # builds error message and executes output_message if conditions are met
    def error message
      message = "ERROR: " + message
      output_message message, @error_color if valid_conditions 3
    end

    # sends log message to stdout with color coding
    def output_message message, color
      case color
        when :black
          puts message.black
        when :red
          puts message.red
        when :green
          puts message.green
        when :yellow
          puts message.yellow
        when :blue
          puts message.blue
        when :magenta
          puts message.magenta
        when :cyan
          puts message.cyan
        else
          puts message.white
      end
    end

    # streams log information to log_file
    def output_to_file message
      @log_file.puts message
      @log_file.flush
    end

    # streams log information to spec/reports/file_name.log
    def output_to_report_file message
      @spec_report_file.puts message
    end

    # This method is called each time a Logger instance is created
    # Tries to find the /spec/reports directory which is created when the rake task is initialized
    # If the directory is found .log file is created in that directory
    # so all log information will be streamed to the file and viewable in hudson
    # after the job has ran
    def create_report
      dir = Dir.pwd
      file_name = "#{@name}.log"
      reports_dir = dir + "/spec/reports"
      if File.directory? reports_dir
        @spec_report_file = File.open(reports_dir + "/" + file_name, 'w')
        @spec_report_file.puts "WatirmarkLog: " + @name
      else
        #spec/Reports directory does not exits
        @spec_report_file = nil
      end
    end

    # returns logger level as an integer
    def get_level
      case @level
        when :debug, 0
          return 0
        when :info, 1
          return 1
        when :warn, 2
          return 2
        when :error, 3
          return 3
        else
          return 0
      end
    end

    # returns true if file_name is valid
    # file name can only contain digits, underscores, characters
    # file must be of type .log
    def valid_file_name
      (@file_name.match(/((\d)|([a-zA-Z])|(_))*.log/).to_s == @file_name)
    end

    # determines if debug, info, warn, or error method is executed
    def valid_conditions level
      (get_level <= level and !@turn_off)
    end
  end
end