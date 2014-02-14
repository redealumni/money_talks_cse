module MoneyTalks
  module Adyen
    module Payments
      class Base < AbstractPayment
        
        extend Savon::Model
        
        include Authorizable

        # HACK =( Adyen's current published WSDL has no support for installments
        # WSDL = "https://pal-test.adyen.com/pal/Payment.wsdl"
      
        attr_accessor :merchant_account, :reference

        # HACK Adyen's current published WSDL has no support for installments (Brazil)
        def wsdl
          if MoneyTalks.development?
            File.expand_path("../wsdl/payment.wsdl", __FILE__)
          elsif MoneyTalks.production?
          end
        end

      end
    end
  end
end
