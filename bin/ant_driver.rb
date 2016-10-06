require "simant"
require "pry"

class AntDriver < Simant::Engine
  def pry
    binding.pry
  end
end

class ThreadedAntDriver < AntDriver
  attr_accessor :threaded_loop
  def iterate_til_ants_done
    threaded_loop = Thread.new do
      super
    end
    iterations
  end
end

class MultiThreadedAntDriver
  attr_accessor :drivers
  attr_accessor :verbose
  def initialize(driver_num)
    @drivers = driver_num.times.map &Proc.new
  end
  def iterate_til_ants_done
    drivers.map do |d|
      d.verbose = verbose
      d.iterate_til_ants_done
    end
    begin
      drivers.each do |d|
        d.threaded_loop.join
      end
    rescue Interrupt
      drivers.each { |d| d.threaded_loop.kill }
      sleep 0.1
    end
  end
  def iterations
    drivers.map(&:iterations)
  end
end

engine = AntDriver.new 8, 2, 2, 2, Simant::Actors::RandomicActor
engines = MultiThreadedAntDriver.new(3) { ThreadedAntDriver.new 4, 2, 2, 3, Simant::Actors::RandomicActor }
engine.verbose = true
# engine.pry
binding.pry
