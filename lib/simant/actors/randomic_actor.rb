module Simant
  module Actors
    class RandomicActor < BaseActor

      def iterate
        if self.ant.has_food?
          if here.is_home?
            self.drop_food
          else
            rand_action
          end
        else
          if here.is_food?
            if here.is_home?
              rand_action
            else
              self.take_food
            end
          else
            rand_action
          end
        end
      end

      def rand_action
        self.send [ :move, :rand_turn].sample
      end

      def rand_turn
        turn [1, -1].sample
      end

    end

  end
end
