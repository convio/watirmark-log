require "spec_helper"

context "Unit Tests for WatirmarkLog color outputs" do
  before :all do
    @log = WatirmarkLog::Logger.new
  end

  specify "debug colors" do
    [:black, :red, :green, :yellow, :blue, :magenta, :cyan, :white].each do |color|
      @log.debug_color = color
      log_output = capture_stdout {
        @log.debug "message with color"
      }
      log_output.string.should == color_match("DEBUG: message with color", color)
    end
  end

  specify "info colors" do
    [:black, :red, :green, :yellow, :blue, :magenta, :cyan, :white].each do |color|
      @log.info_color = color
      log_output = capture_stdout {
        @log.info "message with color"
      }
      log_output.string.should == color_match("INFO: message with color", color)
    end
  end

  specify "warn colors" do
    [:black, :red, :green, :yellow, :blue, :magenta, :cyan, :white].each do |color|
      @log.warn_color = color
      log_output = capture_stdout {
        @log.warn "message with color"
      }
      log_output.string.should == color_match("WARN: message with color", color)
    end
  end

  specify "error colors" do
    [:black, :red, :green, :yellow, :blue, :magenta, :cyan, :white].each do |color|
      @log.error_color = color
      log_output = capture_stdout {
        @log.error "message with color"
      }
      log_output.string.should == color_match("ERROR: message with color", color)
    end
  end

  specify "fatal colors" do
    [:black, :red, :green, :yellow, :blue, :magenta, :cyan, :white].each do |color|
      @log.fatal_color = color
      log_output = capture_stdout {
        @log.fatal "message with color"
      }
      log_output.string.should == color_match("FATAL: message with color", color)
    end
  end

  specify "unknown colors" do
    [:black, :red, :green, :yellow, :blue, :magenta, :cyan, :white].each do |color|
      @log.unknown_color = color
      log_output = capture_stdout {
        @log.unknown "message with color"
      }
      log_output.string.should == color_match("UNKNOWN: message with color", color)
    end
  end
end