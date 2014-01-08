module MoneyTalks
  module Adyen
    module Payments
      class Base < PaymentBase
        
        extend Savon::Model

        class Amount < Struct.new("Amount", :currency, :value)
          alias_method :to_symbolized_hash, :to_h
        end

        attr_accessor :merchant_account, :reference, :shopper_ip, :shopper_email,
          :shopper_reference, :fraud_offset, :select_brand

        def amount(&block)
          @amount ||= Amount.new
          if block_given?
            yield @amount
          else
            @amount
          end
        end

        def serialize_as_symbolized_hash
          SoapObjectBuilder.new(self) do |builder|
            builder.node :payment_request do |n|
              
              builder.default_nodes :merchant_account, :reference, :shopper_ip, :shopper_email,
                :shopper_reference, :fraud_offset, :select_brand
              
              n.node :amount do |amount|
                amount.currency = obj
              end

            end
          end
        end

      end
    end
  end
end
