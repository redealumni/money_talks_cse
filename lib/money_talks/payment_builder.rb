module MoneyTalks
  class PaymentBuilder

    class << self
      def build(&block)
        payment = Adyen::Payments::Base.new 
        payment.instance_eval &block
        payment
      end
    end

  end
end
