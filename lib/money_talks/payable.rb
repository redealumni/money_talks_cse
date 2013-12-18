module MoneyTalks
  module Payable
    
    def authorize(callbacks={}, &data)
      raise NotImplementedError, "Select a provider before calling this method" if MoneyTalks::gateway_adapter.psp.nil?
      payment_data = MoneyTalks::gateway_adapter.payment.evaluate &data
      puts payment_data.inspect
      begin
        response = MoneyTalks::gateway_adapter.send_payment(payment_data)
      rescue Exception => e
        callbacks[:on_error].call("#{e.message} - #{response}")
      end
    end

    def cancel(callbacks={}, &data)      
    end

    def refund(callbacks={}, &data)
    end

  end
end
