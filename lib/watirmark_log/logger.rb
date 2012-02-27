module WatirmarkLog
  class  Logger < LoggerBase
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
      @level = :debug
      @turn_off = false
      @name = name

      @file_name = "#{@name}.log"
      @file_destination = Dir.pwd
      @log_file = nil
      create_report

      @debug_color = colors[:white]
      @info_color = colors[:white]
      @warn_color = colors[:white]
      @error_color = colors[:white]
    end

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

    def debug message
      super message
      output_to_file "DEBUG: " + message if @log_file
      output_to_report_file "DEBUG: " + message if @spec_report_file
    end

    def info message
      super message
      output_to_file "INFO: " + message if @log_file
      output_to_report_file "INFO: " + message if @spec_report_file
    end

    def warn message
      super message
      output_to_file "WARN: " + message if @log_file
      output_to_report_file "WARN: " + message if @spec_report_file
    end

    def error message
      super message
      output_to_file "ERROR: " + message if @log_file
      output_to_report_file "ERROR: " + message if @spec_report_file
    end

    def inspect
      @name
    end

    def colors
      {:black => :black, :red => :red,:green => :green, :yellow => :yellow, :blue => :blue, :magenta => :magenta, :cyan => :cyan, :white => :white}
    end
  end
end