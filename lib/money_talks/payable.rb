module MoneyTalks
  module Payable

    def authorize(callbacks={}, &data)
      raise NotImplementedError, "Select a provider before calling this method" if MoneyTalks::psp_adapter.nil?
      payment_data = MoneyTalks::psp_adapter.payment.evaluate &data
      begin
        response = MoneyTalks::psp_adapter.authorize_payment(payment_data)
        callbacks[:on_success].call(response)
      rescue Exception => e
        callbacks[:on_error].call(response)
      end
    end

    def cancel(callbacks={}, &data)      
    end

    def refund(callbacks={}, &data)
    end

  end
end
