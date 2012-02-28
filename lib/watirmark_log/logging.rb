module WatirmarkLog
  class << self
    attr_accessor :container

    # used to create multiple instances of a WatirmarkLogger
    # returns a hash that contains these instances
    # @logs = WatirmarkLog.logging(:logger1, :logger2)
    def logging(*args)
      if @container == nil
        @container = Hash.new
      end
      args.each do |arg|
        raise ArgumentError "Logger name must be of type String or Symbol.. #{arg} is not a String or Symbol" if arg.class != String and arg.class != Symbol
        raise ArgumentError, "Logger name #{arg} already exists" if @container[arg] != nil
        @container[arg] = WatirmarkLog::Logger.new(arg)
      end
      @container
    end

    # retuns the instance of a WatirmarkLogger
    # @logs.logger(:Logger1)
    def logger(arg)
      raise "Logger #{arg} does not exist" if @container[arg] == nil
      @container[arg]
    end

    # returns a hash off all the color values available for a WatirmarkLogger
    # @logs[:Logger1].debug_color = Watirmark.colors[:red]
    def colors
      {:black => :black, :red => :red,:green => :green, :yellow => :yellow, :blue => :blue, :magenta => :magenta, :cyan => :cyan, :white => :white}
    end
  end
end