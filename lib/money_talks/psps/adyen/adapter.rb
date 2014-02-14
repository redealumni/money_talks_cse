module MoneyTalks
  module Adyen
    class Adapter

      attr_accessor :user, :password
      attr_reader :payment

      def initialize
        @payment = Payments::Base.new
      end

      def connection_handler
        @ws_client ||= Savon.client(
          basic_auth: [user, password],
          wsdl: payment.wsdl,
          convert_request_keys_to: :lower_camelcase,
          pretty_print_xml: MoneyTalks::dev? ? true : false
          )
      end

      def authorize_payment(payment_data)
        #begin
          connection_handler.call(:authorise, message: payment_data.authorize)
        #rescue Exception => e
        #  puts e
        #end
      end

      def refund_payment(refund_info)
        begin
          connection_handler.call(:refund, message: payment_data.refund)
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


