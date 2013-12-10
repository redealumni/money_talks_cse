# encoding: utf-8
money_talks_path = File.dirname(__FILE__)
$LOAD_PATH.unshift(money_talks_path) unless $LOAD_PATH.include?(money_talks_path)

require 'savon'
require 'singleton'

module MoneyTalks
  
  autoload :VERSION, 'money_talks/version.rb'
  autoload :PaymentGatewayAdapter, 'money_talks/payment_gateway_adapter.rb'
  autoload :TransactionNumberGenerator, 'money_talks/transaction_number_generator.rb'
  autoload :Payable, 'money_talks/payable.rb'
  autoload :GatewayAdapter, 'money_talks/gateway_adapter.rb'

  module Payment
    autoload :Base, 'money_talks/payments/base.rb'
    autoload :Adyen, 'money_talks/payments/adyen.rb'
    autoload :PagSeguro, 'money_talks/payments/pag_seguro.rb'
  end

  module Gateway
    autoload :Adyen, 'money_talks/gateways/adyen.rb' 
    autoload :PagSeguro, 'money_talks/gateways/pag_seguro.rb'
  end

end
