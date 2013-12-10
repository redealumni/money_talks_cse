module MoneyTalks
  module Payment
    class Base


      def evaluate(&block)
        instance_eval &block
      end

    end
  end
end
