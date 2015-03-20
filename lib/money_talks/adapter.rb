module MoneyTalks
  class Adapter
    
    attr_reader :psp
    
    class_eval do
      attr = [:user, :password, :use_local_wsdl, :log_output]
      delegate *attr.map { |a| [a, "#{a}=".to_sym]}.flatten, to: :psp
    end

    def initialize(psp)
      @psp = psp
    end

    def payment_decorator
      @psp.payment_decorator
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

    def cancel_or_refund_payment(refund_data)
      @psp.cancel_or_refund_payment(refund_data)
    end

    def capture_payment(capture_data)
      @psp.capture_payment(capture_data)
    end
    
  end
end
