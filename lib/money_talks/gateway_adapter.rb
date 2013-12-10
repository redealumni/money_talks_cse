module MoneyTalks
  class GatewayAdapter

    include Singleton

    attr_accessor :user, :pass, :endpoint, :psp
    alias_method :payment_service_provider, :psp

    def payment_service_provider=(provider)
      begin
        @psp = Object.const_get("MoneyTalks::Gateway::#{provider.capitalize!}").new
      rescue NameError => e
        raise NameError, "Provider #{provider} not available: #{e}"
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

  end
end
