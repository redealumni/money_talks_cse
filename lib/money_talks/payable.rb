module MoneyTalks
  module Payable

    def authorize(callbacks={}, &data)
      begin
        adapter.authorize_payment(callbacks, &data)
      rescue Exception => e

      end
    end

    def cancel(callbacks={}, &data)      
      adapter.cancel_payment(callbacks, &data)
    end

    def capture(callbacks={}, &data)
      adapter.capture_payment(callbacks, &data)
    end

    def refund(callbacks={}, &data)
      adapter.refund_payment(callbacks, &data)
    end

    private

    def adapter
      MoneyTalks::Client.adapter
    end
  
  end
end
