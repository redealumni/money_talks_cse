module MoneyTalks
  class GatewayAdapter

    include Singleton

    attr_accessor :gateway

    def payment
      @gateway.payment
    end

    def send_payment(payment_info)
      @gateway.send_payment(payment_info)
    end

    def refund_payment(refund_info)
      @gateway.refund_payment(refund_info)
    end

    def cancel_payment(cancel_info)
      @gateway.cancel_payment(cancel_info)
    end

    # informa o gateway que recebeu o post back
    def post_back_acknowledgment(token)
      @gateway.post_back_acknowledgment(token)
    end

  end
end
