module WatirmarkLog
  class LoggerBase

    # builds debug message and executes output_message if valid_conditions are met
    def debug message
      message = "DEBUG: " + process_message(message)
      output_message message, @debug_color if valid_conditions 0
    end

    def debug_pp message
      message = "DEBUG: " + process_pp_message(message)
      output_message message, @debug_color if valid_conditions 0
    end

    # builds info message and executes output_message if conditions are met
    def info message
      message = "INFO: " + process_message(message)
      output_message message, @info_color if valid_conditions 1
    end

    def info_pp message
      message = "INFO: " + process_pp_message(message)
      output_message message, @info_color if valid_conditions 1
    end

    # builds info message and executes output_message if conditions are met
    def warn message
      message = "WARN: " + process_message(message)
      output_message message, @warn_color if valid_conditions 2
    end

    def warn_pp message
      message = "WARN: " + process_pp_message(message)
      output_message message, @warn_color if valid_conditions 2
    end

    # builds error message and executes output_message if conditions are met
    def error message
      message = "ERROR: " + process_message(message)
      output_message message, @error_color if valid_conditions 3
    end

    def error_pp message
      message = "ERROR: " + process_pp_message(message)
      output_message message, @error_color if valid_conditions 3
    end

    def fatal message
      message = "FATAL: " + process_message(message)
      output_message message, @fatal_color if valid_conditions 4
    end

    def fatal_pp message
      message = "FATAL: " + process_pp_message(message)
      output_message message, @fatal_color if valid_conditions 4
    end

    def unknown message
      message = "UNKNOWN: " + process_message(message)
      output_message message, @unknown_color if valid_conditions 5
    end

    def unknown_pp message
      message = "UNKNOWN: " + process_pp_message(message)
      output_message message, @unknown_color if valid_conditions 5
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
          puts message
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
        when 0, 1, 2, 3, 4, 5
          return @level
        else
          return WatirmarkLog::Level::DEBUG
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

    def process_message message
      output = message
      if message.class != String
        object_output = capture_output {
          puts message
        }
        output = "\n" + object_output.string
      end
      output
    end

    def process_pp_message message
      object_output = capture_output {
        pp message
      }
      object_output.string
    end

    def capture_output
      begin
        out = StringIO.new
        $stdout = out
        yield
        return out
      ensure
        $stdout = STDOUT
      end
    end
  end
end