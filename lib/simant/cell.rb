
module Simant
  class Cell
    attr_accessor :ant
    attr_accessor :food_pheromone
    attr_accessor :home_pheromone
    attr_accessor :food
    attr_accessor :home

    def initialize(food, home_pheromone, food_pheromone)
      @food, @home_pheromone, @food_pheromone = food, home_pheromone, food_pheromone
    end

    def is_home?
      self.home
    end

    def is_food?
      self.food > 0
    end

  end
end
