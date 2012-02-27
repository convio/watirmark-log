require "spec_helper"

context "Unit tests for WatirmarkLog Debug, Info, Warn, and Error outputs" do
  before :all do
    @log = WatirmarkLog::Logger.new
  end

  specify "DEBUG" do
    log_output = capture_stdout {
      @log.debug "This is a debug message from #{@log.inspect}"
    }
    log_output.string.should match(/DEBUG: This is a debug message from WatirmarkLog/)
  end

  specify "INFO" do
    log_output = capture_stdout {
      @log.info "This is an info message from #{@log.inspect}"
    }
    log_output.string.should match(/INFO: This is an info message from WatirmarkLog/)
  end

  specify "WARN" do
    log_output = capture_stdout {
      @log.warn "This is a warn message from #{@log.inspect}"
    }
    log_output.string.should match(/WARN: This is a warn message from WatirmarkLog/)
  end

  specify "ERROR" do
    log_output = capture_stdout {
      @log.error "This is an error message from #{@log.inspect}"
    }
    log_output.string.should match(/ERROR: This is an error message from WatirmarkLog/)
  end
end
