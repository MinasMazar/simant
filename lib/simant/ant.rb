
module Simant
  class Ant
    attr_accessor :location
    attr_accessor :direction
    attr_accessor :food

    def initialize(location, direction)
      @location, @direction  = location, direction
      @food = 0
    end

    def has_food?
      food > 0
    end

    def id
      "#{has_food? ? "A" : "a"}#{location}"
    end

  end
end
