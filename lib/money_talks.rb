# encoding: utf-8
money_talks_path = File.dirname(__FILE__)
$LOAD_PATH.unshift(money_talks_path) unless $LOAD_PATH.include?(money_talks_path)

require 'savon'
require 'singleton'
require 'active_support/core_ext'

module MoneyTalks
  
  autoload :VERSION, 'money_talks/version.rb'
  autoload :PaymentGatewayAdapter, 'money_talks/payment_gateway_adapter.rb'
  autoload :TransactionNumberGenerator, 'money_talks/transaction_number_generator.rb'
  autoload :Payable, 'money_talks/payable.rb'
  autoload :GatewayAdapter, 'money_talks/gateway_adapter.rb'
  
  # Exceptions
  autoload :PSPNotSupportedError, 'money_talks/exceptions.rb'
  autoload :FieldNotSupportedError, 'money_talks/exceptions.rb'

  module Payment
    autoload :Base, 'money_talks/payments/base.rb'
    autoload :Adyen, 'money_talks/payments/adyen.rb'
    autoload :PagSeguro, 'money_talks/payments/pag_seguro.rb'
  end

  module Gateway
    autoload :Adyen, 'money_talks/gateways/adyen.rb' 
    autoload :PagSeguro, 'money_talks/gateways/pag_seguro.rb'
  end

  class << self

    #attr_accessor :gateway_adapter

    # FIXME ||=
    def gateway_adapter
      @gateway_adapter = MoneyTalks::GatewayAdapter.instance
    end

    def configure
      begin
        yield(gateway_adapter)
      rescue NoMethodError => e
        raise FieldNotSupportedError, "The field #{e.name} is not supported by the provider #{gateway_adapter.to_s}"
      end
    end

  end

end
