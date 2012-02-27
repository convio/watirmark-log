require "spec_helper"

context "Unit Tests for create_file method" do
  before :all do
    @log = WatirmarkLog::Logger.new
    Dir.chdir "../.."
  end

  specify "create a file" do
    @log.create_file
    capture_stdout {
      @log.debug "this is a debug message"
      @log.info "this is an info message"
      @log.warn "this is a warn message"
      @log.error "this is an error message"
    }
    file = File.new("WatirmarkLog.log", "r")
    file_text = ""
    while (line = file.gets)
      file_text = file_text + line
    end
    file_text.should == "WatirmarkLog: WatirmarkLog\nDEBUG: this is a debug message\nINFO: this is an info message\nWARN: this is a warn message\nERROR: this is an error message\n"
  end

  specify "should not allow .text files" do
    lambda { @log.create_file "log.text" }.should raise_error
  end

  specify "should not allow special characters " do
    lambda { @log.create_file "special#_@characters.log" }.should raise_error
  end
end