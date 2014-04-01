module MoneyTalks
  class Payment
   

    def initialize(payment_method)
      @payment_method = payment_method
    end

    def authorize
      response = adapter.authorize_payment(self)
      if block_given?
        yield response
      else
        response
      end
    end

    def cancel(callbacks={}, &data)      
      adapter.cancel_payment(callbacks, &data)
    end

    def refund(callbacks={}, &data)
      adapter.refund_payment(callbacks, &data)
    end

    def capture(callbacks={}, &data)
      adapter.capture_payment(callbacks, &data)
    end

    private

    def adapter
      MoneyTalks::adapter
    end
  
  end
end
