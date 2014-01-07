module MoneyTalks
  class PSPAdapter

    include Singleton
    
    attr_reader :psp

    delegate :user=, :password=, :wsdl=, :payment, to: :psp

    def psp=(provider)
      @name = provider.to_s

      begin
        @psp = Object.const_get("MoneyTalks::#{@name.camelize}::Adapter").new
      rescue NameError => e
        # puts e
        
        #raise PSPNotSupportedError, "Provider #{provider.camelize} not available. Implement it first"
      end

    end


    def authorize_payment(payment_info)
      @psp.authorize_payment(payment_info)
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
