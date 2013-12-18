module MoneyTalks
  module Adyen
    module Payments
      class Base < PaymentBase
        
        include Serializable
        extend Savon::Model

        class Amount < Struct.new("Amount", :currency, :value) 
          include Serializable
        end

        
        attr_accessor :merchant_account, :amount, :reference, :reference, :shopper_id, 
                      :shopper_email, :shopper_reference, :fraud_offset, 
                      :select_brand

        def amount(&block)
          @amount ||= Amount.new
          if block_given?
            yield @amount
          else
            @amount
          end
        end

        def payment_method(method=nil)
          # Raise exception if payment method doesnt exist
          @payment_method ||= Object.const_get("MoneyTalks::Adyen::Payments::#{method.to_s.camelize}").new
          if block_given?
            yield @payment_method
          else
            @payment_method
          end
        end

        def serialize
        end

      end
    end
  end
end
