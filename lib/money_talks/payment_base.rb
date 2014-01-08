module MoneyTalks
  class PaymentBase

    def evaluate(&block)
      instance_eval &block
      self
    end

    def payment_method(method=nil)
      # Raise exception if payment method doesnt exist
      @payment_method_name = method
      @payment_method ||= Object.const_get("MoneyTalks::Adyen::Payments::#{@payment_method_name.to_s.camelize}").new
      if block_given?
        yield @payment_method
      else
        @payment_method
      end
    end

    def payment_method_name
      @payment_method_name
    end

    def soap_model

    end


  end
end
