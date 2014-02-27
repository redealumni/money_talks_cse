module MoneyTalks
  module Adyen
    class Adapter

      attr_accessor :user, :password, :use_local_wsdl
        
      # HACK =( Adyen's current published WSDL has no support for installments
      PUBLISHED_TEST_URL = "https://pal-test.adyen.com/pal/Payment.wsdl"
      PUBLISHED_LIVE_URL = "https://pal-live.adyen.com/pal/Payment.wsdl"

      def connection_handler
        @ws_client ||= Savon.client(
          basic_auth: [user, password],
          wsdl: wsdl,
          convert_request_keys_to: :lower_camelcase,
          pretty_print_xml: MoneyTalks::dev? ? true : false
          )
      end

      # HACK Adyen's current published WSDL has no support for installments (Brazil)
      # use the local version
      def wsdl
        case MoneyTalks.env.to_sym
          when :production
            :use_local_wsdl ? local_wsdl(:production) : PUBLISHED_LIVE_URL
          when :development
            :use_local_wsdl ? local_wsdl(:development) : PUBLISHED_TEST_URL
          when :test
            :use_local_wsdl ? local_wsdl(:test) : PUBLISHED_TEST_URL
        end
      end

      def local_wsdl(env)
        File.expand_path("../wsdl/#{env.to_s}/payment.wsdl", __FILE__)
      end

      def authorize_payment(data)
        begin
          connection_handler.call(:authorise, message: data.serialize_as(:payment_request))
        rescue Exception => e
          puts e
        end
      end

      def refund_payment(data)
        #begin
          connection_handler.call(:refund, message: data.serialize_as(:modification_request))
        #rescue Exception => e
        #end
      end
      
      def capture_payment(data)
        #begin
          connection_handler.call(:capture, message: data.serialize(:modification_request))
        #rescue Exception => e
        #end
      end

      def cancel_payment(cancel_info)
        connection_handler.call(:cancel, message: data.serialize_as(:modification_request))
      end

    end
  end
end


