module MoneyTalks
  class Adapter
    
    attr_reader :psp
    
    class_eval do
      attr = [:user, :password, :use_local_wsdl]
      delegate *attr.map { |a| [a, "#{a}=".to_sym]}.flatten, to: :psp
    end

    def initialize(psp)
      @psp = psp
    end

    def authorize_payment(callbacks={}, &payment_data)
      call!(:authorize, callbacks, &payment_data)
    end

    def refund_payment(callbacks={}, &refund_data)
      call!(:refund, callbacks, &refund_data)
    end

    def cancel_payment(callbacks={}, &cancel_data)
      call!(:cancel, callbacks, &cancel_data)
    end
    
    private
    
    def call!(method, callbacks={}, &data)
      payment_data = PaymentBuilder.build(&data)
 
      #begin  
        response = @psp.send("#{method.to_s}_payment", payment_data)
        callbacks[:on_success].call(response)
#      rescue Exception => e
        callbacks[:on_error].call(response)
      #end
    end

  end
end
