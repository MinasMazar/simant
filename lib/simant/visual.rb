
module Simant
  module Visual

    def print_world(world)
      world_str_map = []
      world.each do |cell, location|
        world_str_map << "|" if location[1] == 0
        world_str_map << " " << print_cell(cell) << " "
        world_str_map << "|\n" if location[1] == world.size - 1
      end
      world_str_map.join
    end

    def print_cell(cell)
      if cell.ant
        cell.ant.has_food? ? "A" : "a"
      else
        cell.food.to_s
      end
    end

  end
end
