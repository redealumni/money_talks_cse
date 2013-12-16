module MoneyTalks
  class GatewayAdapter

    include Singleton

    attr_accessor :user, :password, :webservice_endpoint, :psp
    
    alias_method :payment_service_provider, :psp

    def payment_service_provider=(provider)
      @name = provider.to_s

      begin
        @psp = Object.const_get("MoneyTalks::Gateway::#{@name.camelize}").new
      rescue NameError
        raise PSPNotSupportedError, "Provider #{provider.camelize} not available. Implement it first"
      end

    end

    def payment
      @psp.payment
    end

    def send_payment(payment_info)
      @psp.send_payment(payment_info)
    end

    def refund_payment(refund_info)
      @psp.refund_payment(refund_info)
    end

    def cancel_payment(cancel_info)
      @psp.cancel_payment(cancel_info)
    end

    def post_back_acknowledgment(token)
      @psp.post_back_acknowledgment(token)
    end

    def to_s
      @name
    end

  end
end
