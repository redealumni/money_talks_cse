module MoneyTalks
  module Adyen
    class Adapter

      PAYMENT_WSDL = "https://pal-test.adyen.com/pal/Payment.wsdl"

      attr_accessor :user, :password
      attr_reader :payment

      def initialize
        @payment = Payments::Base.new
      end

      def connection_handler
        @ws_client ||= Savon.client(basic_auth: [user, password]) do 
          wsdl PAYMENT_WSDL 
          convert_request_keys_to :lower_camelcase
        end
      end

      def authorize_payment(payment_info)
        begin
          connection_handler.call(:authorise, message: payment_info.serialize_as_symbolized_hash)
        rescue Exception => e

        end
      end

      def refund_payment(refund_info)
        begin
          connection_handler.call(:refund)
        rescue Exception => e

        end
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


