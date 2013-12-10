module MoneyTalks
  module Gateway
    class Adyen

      def payment
        MoneyTalks::Payment::Adyen.new
      end

      # return 
      def send_payment(payment_info)
        raise NotImplementedError
      end

      def refund_payment(refund_info)
        raise NotImplementedError
      end

      def cancel_payment(cancel_info)
        raise NotImplementedError
      end

      # informa o gateway que recebeu o post back
      def post_back_acknowledgment(token)
        raise NotImplementedError
      end

    end
  end
end

