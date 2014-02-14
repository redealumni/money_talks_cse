module MoneyTalks
  module Adyen
    module Authorizable
        
      attr_accessor :shopper_IP, :shopper_email, :shopper_reference, :fraud_offset, :select_brand, :authorization_code,
      :selected_brand, :shopper_statement, :selected_brand, :social_security_number, :delivery_date

      def amount(&block)
        @amount ||= OpenStruct.new
        if block_given?
          yield @amount
        else
          @amount
        end
      end

      def installments(&block)
        @installments ||= OpenStruct.new
        if block_given?
          yield @installments
        else
          @installments
        end
      end
      
      def billing_address(&block)
        @billing_address ||= OpenStruct.new
        if block_given?
          yield @billing_address
        else
          @billing_address
        end
      end

      def shopper_name(&block)
        @shopper_name ||= OpenStruct.new
        if block_given?
          yield @shopper_name
        else
          @shopper_name
        end
      end

      # Adyen's API for Boletos don't follow the same message pattern
      def payment_method(method=nil)
        # Raise exception if payment method doesnt exist
        if block_given?
          payment_method = Object.const_get("MoneyTalks::Adyen::Payments::#{method.to_s.camelize}").new
          self.instance_variable_set("@#{method}",payment_method)
          yield instance_variable_get("@#{method}")
        else
          instance_variable_get("@#{method}")
        end
      end

      def authorize
        {payment_request: Hash[self.instance_variables.map do |v|
          symbolized_key = v.to_s.gsub("@","").to_sym
          if self.instance_variable_get(v).kind_of? OpenStruct
            [symbolized_key, self.instance_variable_get(v).to_h]
          else
            [symbolized_key, self.instance_variable_get(v)]
          end
        end
        ]}
      end
    
    end
  end
end
