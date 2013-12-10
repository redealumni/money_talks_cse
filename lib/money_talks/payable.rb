module MoneyTalks
  module Payable

    def gateway_provider(provider)
      begin
        provider = Object.const_get("PayGem::Gateway::#{provider.capitalize!}")
        @adapter = MoneyTalks::GatewayAdapter.instance
        @adapter.gateway = provider.new
      rescue NameError => e
        raise NameError, "Provider #{provider} not available: #{e}"  
      end
    end
    
    def send_payment(callbacks={}, &data)
      raise NotImplementedError, "Select a provider before calling this method" if @adapter.nil?
      provider_specific = @adapter.payment.instance_eval(&data)
      response = @adapter.send_payment(provider_specific)
      callbacks[:on_success].call response
    end

    def cancel_payment(callbacks={}, &data)      
    end

    def refund_payment(callbacks={}, &data)
    end

  end
end
