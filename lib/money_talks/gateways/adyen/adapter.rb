module MoneyTalks
  module Adyen
    class Adapter < MoneyTalks::AbstractGateway

      attr_reader :payment

      def initialize
        @client = Savon.client(wsdl: self.webservice_endpoint)
      end

      def build_payment
        @payment = Payments::Base.new
      end

      # return 
      def send_payment(payment)
        @client.call(:authorize) do
          message payment.serialize
          convert_request_keys_to :camelcase        
        end
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


