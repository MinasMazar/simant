require "simant/cell"

module Simant
  class World
    attr_accessor :size
    attr_accessor :data

    def initialize(world_size)
      @size = world_size
      @data = size.times.map { |col| size.times.map { Cell.new 0,0,0 } }
    end

    def [](x, y = nil)
      if x.is_a?(Array) && (x.size == 2)
        data[x[0]][x[1]]
      else
        data[x][y]
      end
    end

    def sample
      self.data.sample.sample
    end

    def each
      data.each_with_index do |col, x|
        col.each_with_index do |cell, y|
          yield cell, [x,y]
        end
      end
    end

  end
end
