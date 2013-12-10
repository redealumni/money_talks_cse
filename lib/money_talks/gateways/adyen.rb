module MoneyTalks
  module Gateway
    class Adyen

      def payment
        MoneyTalks::Payment::Adyen.new
      end

      # return status code
      def send_payment(payment_info)
        "200"
        #raise ExampleError
        #begin
          #response = @gateway.send_payment(payment_info)
          #callbacks[:on_success].call response
        #rescue Exception => e
          #callbacks[:on_error].call response
        #end
      end

      def refund_payment(callbacks={})
        begin
          @gateway.refund_payment(refund_info)
        rescue Exception => e
          
        end
      end

      def cancel_payment(callbacks={})
        @gateway.cancel_payment
      end

      # informa o gateway que recebeu o post back
      def post_back_acknowledgment(token)
        @gateway.post_back_acknowledgment(token)
      end

    end
  end
end

