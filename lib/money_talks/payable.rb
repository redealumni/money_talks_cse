module MoneyTalks
  module Payable

    #def gateway_provider(provider)
      #begin
        #provider = Object.const_get("MoneyTalks::Gateway::#{provider.capitalize!}")
        #@adapter = MoneyTalks::GatewayAdapter.instance
        #@adapter.gateway = provider.new
      #rescue NameError => e
        #raise NameError, "Provider #{provider} not available: #{e}"  
      #end
    #end
    
    def pay(callbacks={}, &data)
      puts MoneyTalks::gateway_adapter.inspect
      raise NotImplementedError, "Select a provider before calling this method" if MoneyTalks::gateway_adapter.psp.nil?
      provider_specific = MoneyTalks::gateway_adapter.payment.evaluate &data
      begin
        response = MoneyTalks::gateway_adapter.send_payment(provider_specific)
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
