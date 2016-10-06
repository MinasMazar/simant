require "simant/ant"
require "simant/world"

module Simant
  module Actors
    class BaseActor
      DIR_DELTA   = [ [0, -1], [ 1, -1], [ 1, 0], [ 1,  1], [0, 1], [-1, 1], [-1, 0], [-1, -1] ]

      attr_accessor :ant
      attr_accessor :world

      def initialize(ant, world)
        @ant, @world = ant, world
      end

      def turn(amt)
        ant.direction = (ant.direction + amt) % 8
        Simant.logger.info "The ant #{ant.id} at #{ant.location} is turning in direction #{amt}"
        self
      end

      def move
        new_location = neighbor ant.direction
        Simant.logger.info "The ant #{ant.id} at #{ant.location} is moving from #{ant.location} to #{new_location}"
        ahead.ant = ant
        here.ant = nil
        ant.location = new_location
        self
      end

      def drop_food
        Simant.logger.info "The ant #{ant.id} at #{ant.location} is dropping down food at #{ant.location}"
        here.food += 1
        ant.food -= 1
        self
      end

      def take_food
        Simant.logger.info "The ant #{ant.id} at #{ant.location} is taking food at #{ant.location}"
        here.food -= 1
        ant.food += 1
        self
      end

      def here
        world[ant.location]
      end

      def ahead
        world[neighbor(ant.direction)]
      end

      def ahead_left
        world[neighbor(ant.direction + 1)]
      end

      def ahead_right
        world[neighbor(ant.direction - 1)]
      end

      def nearby_places
        [ ahead, ahead_left, ahead_right]
      end

      def iterate
        raise "#{self.class} does not implement #iterate method"
      end

      private

      def neighbor(direction)
        x,y = ant.location

        dx, dy = DIR_DELTA[direction % 8]

        [(x + dx) % world.size, (y + dy) % world.size]
      end

    end

  end
end
