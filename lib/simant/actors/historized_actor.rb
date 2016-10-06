require "set"

module Simant
  module Actors
    class HistorizedActor < BaseActor

      def initialize(ant, world)
        super ant, world
        @history = Set.new
      end

    end
  end
end
