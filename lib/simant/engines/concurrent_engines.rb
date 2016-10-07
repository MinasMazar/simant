module Simant
  module Engines
    module ThreadedAntEngine
      attr_accessor :threaded_loop
      def iterate_til_ants_done
        self.threaded_loop = Thread.new do
          super
        end
        iterations
      end
    end

    class MultiThreadedAntEngine
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
          drivers.each_with_index do |d, i|
            puts "Engine #{i}: Ants done after #{d.iterations} iterations"
          end
          iterations
        rescue Interrupt
          drivers.each { |d| d.threaded_loop.kill }
          sleep 0.1
        end
      end
      def iterations
        drivers.map(&:iterations)
      end
    end

  end
end
