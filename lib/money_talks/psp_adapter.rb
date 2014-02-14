module MoneyTalks
  class PSPAdapter

    include Singleton
    
    attr_reader :psp
    
    class_eval do
      accessor_attributes = [:user, :password, :wsdl, :payment]
      delegate *accessor_attributes.map { |a| [a, "#{a}=".to_sym]}.flatten, to: :psp
    end

    def psp=(provider)
      begin
        @name = provider.to_s; @psp = Object.const_get("MoneyTalks::#{@name.camelize}::Adapter").new
      rescue NameError => e
        raise PSPNotSupportedError, "Provider #{provider.camelize} not available. Implement it first"
      end
    end

    def authorize_payment(payment_data)
      @psp.authorize_payment(payment_data)
    end

    def refund_payment(refund_data)
      @psp.refund_payment(refund_data)
    end

    def cancel_payment(cancel_data)
      @psp.cancel_payment(cancel_data)
    end

    def post_back_acknowledgment(token)
      @psp.post_back_acknowledgment(token)
    end

    def to_s
      @name
    end

  end
end
