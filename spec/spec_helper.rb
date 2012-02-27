$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require "stringio"
require 'watirmark-log'

alias :context :describe

module WatirmarkLogTest
  def capture_stdout
    out = StringIO.new
    $stdout = out
    yield
    return out
  ensure
    $stdout = STDOUT
  end

  def color_match( message, color)
    message = message
    case color
      when :black
        message = "\e[30m#{message}\e[0m\n"
      when :red
        message = "\e[31m#{message}\e[0m\n"
      when :green
        message = "\e[32m#{message}\e[0m\n"
      when :yellow
        message = "\e[33m#{message}\e[0m\n"
      when :blue
        message = "\e[34m#{message}\e[0m\n"
      when :magenta
        message = "\e[35m#{message}\e[0m\n"
      when :cyan
        message = "\e[36m#{message}\e[0m\n"
      when :white
        message = "\e[37m#{message}\e[0m\n"
      else
        raise ArgumentError, "cannot find color '#{color}'"
    end
    message
  end
end

RSpec.configure do |config|
  config.include WatirmarkLogTest
end
