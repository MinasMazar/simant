require "simant/visual"

module Simant
  module Engines
    class BasicEngine

      include Visual

      ANT_SLEEP = 0

      attr_writer :name

      attr_accessor :world
      attr_accessor :actors
      attr_accessor :food_places
      attr_accessor :food_range
      attr_accessor :home_cell

      attr_accessor :iterations
      attr_accessor :ants_done

      attr_accessor :verbose

      def initialize(world_size, food_places, food_range, ant_number, actor_klass = Simant::Actors::BaseActor)
        @world = Simant::World.new world_size
        @actors = []
        @food_places, @food_range = food_places, food_range

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
        puts_if_verbose "Engine #{name}: Starting simulation"
        puts_if_verbose print_world world
        until ants_done?
          Simant.logger.info "Iteration n.#{iterations}"
          iterate
          puts_if_verbose "Iteration ##{iterations}"
          puts_if_verbose print_world world
        end
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

      def food_seeds
        food_places * food_range
      end

      def name
        @name ||= "<#{self.class.name.split("::").last}-W#{world.size}S#{food_seeds}A#{ants.size}>"
      end

      private

      def puts_if_verbose(str)
        puts str if verbose
      end

    end
  end
end
