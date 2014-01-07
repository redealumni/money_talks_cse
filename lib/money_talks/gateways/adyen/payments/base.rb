module MoneyTalks
  module Adyen
    module Payments
      class Base < PaymentBase
        
        extend Savon::Model
        include MoneyTalks::SavonSerializationSupport

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

        def payment_method(method=nil)
          # Raise exception if payment method doesnt exist
          @payment_method ||= Object.const_get("MoneyTalks::Adyen::Payments::#{method.to_s.camelize}").new
          if block_given?
            yield @payment_method
          else
            @payment_method
          end
        end

        # FIXME hack temporário
        def serialize_as_symbolized_hash
          serialized_model = {}
          serialized_model.store(:payment_request,'')
          serialized_model[:payment_request] = self.to_symbolized_hash
          serialized_model[:payment_request][:card] = self.payment_method.to_symbolized_hash
          serialized_model[:payment_request][:amount] = self.amount.to_symbolized_hash
          serialized_model
        end

      end
    end
  end
end
