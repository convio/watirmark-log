require "spec_helper"

context "Unit Tests for WatirmarkLog Hierarchy: (debug < info < warn < error)" do
  before :all do
    @log = WatirmarkLog::Logger.new
  end

  specify "debug level should allow all log methods to be executed" do
    [WatirmarkLog::Level::DEBUG, 0].each do |level|
      @log.level = level
      log_output = capture_stdout {
        @log.debug "debug message"
        @log.info "info message"
        @log.warn "warn message"
        @log.error "error message"
        @log.fatal "fatal message"
        @log.unknown "unknown message"
      }
      log_output.string.should match(/DEBUG: debug message/) and match(/INFO: info message/) and match(/WARN: warn message/) and match(/ERROR: error message/) and match(/FATAL: fatal message/) and match(/UNKNOWN: unknown message/)
    end
  end

  specify "info level should not allow debug level log methods to be executed" do
    [WatirmarkLog::Level::INFO, 1].each do |level|
      @log.level = level
      log_output = capture_stdout {
        @log.debug "debug message"
        @log.info "info message"
        @log.warn "warn message"
        @log.error "error message"
        @log.fatal "fatal message"
        @log.unknown "unknown message"
      }
      log_output.string.should match(/INFO: info message/) and match(/WARN: warn message/) and match(/ERROR: error message/) and match(/FATAL: fatal message/) and match(/UNKNOWN: unknown message/)
      log_output.string.should_not match(/DEBUG: debug message/)
    end
  end

  specify "warn level should not allow debug, and info level log methods to be executed" do
    [WatirmarkLog::Level::WARN, 2].each do |level|
      @log.level = level
      log_output = capture_stdout {
        @log.debug "debug message"
        @log.info "info message"
        @log.warn "warn message"
        @log.error "error message"
        @log.fatal "fatal message"
        @log.unknown "unknown message"
      }
      log_output.string.should match(/WARN: warn message/) and match(/ERROR: error message/) and match(/FATAL: fatal message/) and match(/UNKNOWN: unknown message/)
      log_output.string.should_not match(/DEBUG: debug message/) and match(/INFO: info message/)
    end
  end

  specify "error level should not allow debug, info, and warn level log methods to be executed" do
    [WatirmarkLog::Level::ERROR, 3].each do |level|
      @log.level = level
      log_output = capture_stdout {
        @log.debug "debug message"
        @log.info "info message"
        @log.warn "warn message"
        @log.error "error message"
        @log.fatal "fatal message"
        @log.unknown "unknown message"
      }
      log_output.string.should match(/ERROR: error message/) and match(/FATAL: fatal message/) and match(/UNKNOWN: unknown message/)
      log_output.string.should_not match(/DEBUG: debug message/) and match(/INFO: info message/) and match(/WARN: warn message/)
    end
  end

  specify "fatal level should not allow debug, info, warn, and errir level log methods to be executed" do
    [WatirmarkLog::Level::FATAL, 4].each do |level|
      @log.level = level
      log_output = capture_stdout {
        @log.debug "debug message"
        @log.info "info message"
        @log.warn "warn message"
        @log.error "error message"
        @log.fatal "fatal message"
        @log.unknown "unknown message"
      }
      log_output.string.should match(/FATAL: fatal message/) and match(/UNKNOWN: unknown message/)
      log_output.string.should_not match(/DEBUG: debug message/) and match(/INFO: info message/) and match(/WARN: warn message/) and match(/ERROR: error message/)
    end
  end

  specify "unknown level should not allow debug, info, warn, and errir level log methods to be executed" do
    [WatirmarkLog::Level::UNKNOWN, 5].each do |level|
      @log.level = level
      log_output = capture_stdout {
        @log.debug "debug message"
        @log.info "info message"
        @log.warn "warn message"
        @log.error "error message"
        @log.fatal "fatal message"
        @log.unknown "unknown message"
      }
      log_output.string.should match(/UNKNOWN: unknown message/)
      log_output.string.should_not match(/DEBUG: debug message/) and match(/INFO: info message/) and match(/WARN: warn message/) and match(/ERROR: error message/) and  match(/FATAL: fatal message/)
    end
  end

  specify "Any level that is not expected should allow all log methods to be executed" do
    [:invalid, 89484].each do |level|
      @log.level = level
      log_output = capture_stdout {
        @log.debug "debug message"
        @log.info "info message"
        @log.warn "warn message"
        @log.error "error message"
        @log.fatal "fatal message"
        @log.unknown "unknown message"
      }
      log_output.string.should match(/DEBUG: debug message/) and match(/INFO: info message/) and match(/WARN: warn message/) and match(/ERROR: error message/) and match(/FATAL: fatal message/) and match(/UNKNOWN: unknown message/)
    end
  end
end