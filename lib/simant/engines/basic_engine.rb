require "simant/visual"

module Simant
  module Engines
    class BasicEngine

      include Visual

      ANT_SLEEP = 0

      attr_accessor :world
      attr_accessor :actors
      attr_accessor :food_seeds
      attr_accessor :home_cell

      attr_accessor :iterations
      attr_accessor :ants_done

      attr_accessor :verbose

      def initialize(world_size, food_places, food_range, ant_number, actor_klass = Simant::Actors::BaseActor)
        @world = Simant::World.new world_size
        @food_seeds = food_places * food_range
        @actors = []

        # Places home
        @home_cell = world.sample
        @home_cell.home = true

        # Places food
        food_places.times do
          food_place = world.sample
          food_place.food = food_range
        end

        # Create Ants/Actors
        ant_number.times do |i|
          koord = [ rand(world.size), rand(world.size) ]
          ant = Simant::Ant.new koord, rand(8)
          actor = actor_klass.new ant, @world
          world[koord].ant = ant
          @actors << actor
        end

        # Iteration settings
        @ants_done = false
        @iterations = 0
      end

      def ants
        self.actors.map(&:ant)
      end

      def iterate_til_ants_done
        puts_if_verbose "Starting simulation"
        puts_if_verbose print_world world
        until ants_done?
          Simant.logger.info "Iteration n.#{iterations}"
          iterate
          puts_if_verbose "Iteration ##{iterations}"
          puts_if_verbose print_world world
        end
        puts_if_verbose "Ants done after #{iterations} iterations"
        iterations
      end

      def iterate
        self.actors.each do |actor|
          self.iterations += 1
          actor.iterate
          sleep ANT_SLEEP if ANT_SLEEP > 0
        end
        if ants_done?
          Simant.logger.info "The Ants dropped all #{food_seeds} in the home#{home_cell}"
        end
      end

      def ants_done?
        if home_cell.food == food_seeds
          self.ants_done = true
        end
      end

      private

      def puts_if_verbose(str)
        puts str if verbose
      end

    end
  end
end
