module WatirmarkLog
  class LoggerBase
    def debug message
      message = "DEBUG: " + message
      process_message message, :debug if valid_conditions 0
    end

    def info message
      message = "INFO: " + message
      process_message message, :info if valid_conditions 1
    end

    def warn message
      message = "WARN: " + message
      process_message message, :warn if valid_conditions 2
    end

    def error message
      message = "ERROR: " + message
      process_message message, :error if valid_conditions 3
    end

    def process_message message, level
      case level
        when :debug
          output_message message, @debug_color
        when :info
          output_message message, @info_color
        when :warn
          output_message message, @warn_color
        when :error
          output_message message, @error_color
      end
    end

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

    def output_to_file message
      @log_file.puts message
      @log_file.flush
    end

    def output_to_report_file message
      @spec_report_file.puts message
    end

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

    def valid_file_name
      (@file_name.match(/((\d)|([a-zA-Z])|(_))*.log/).to_s == @file_name)
    end

    def valid_conditions level
      (get_level <= level and !@turn_off)
    end

    def invalid_message
      puts "LOG ERROR: invalid log message"
    end
  end
end