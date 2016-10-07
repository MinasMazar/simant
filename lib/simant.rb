require "logger"
require "simant/version"
require "simant/world"
require "simant/ant"
require "simant/actor"
require "simant/engine"

module Simant

  def self.debug=(flag)
    @logger = flag ? Logger.new(STDERR) : Logger.new("/dev/null")
  end
  def self.logger
    @logger ||= debug true
  end

end
