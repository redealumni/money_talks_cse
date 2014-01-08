# encoding: utf-8
money_talks_path = File.dirname(__FILE__)
$LOAD_PATH.unshift(money_talks_path) unless $LOAD_PATH.include?(money_talks_path)

require 'savon'
require 'singleton'
require 'active_support/core_ext'

module MoneyTalks
  
  autoload :VERSION, 'money_talks/version.rb'
  autoload :TransactionNumberGenerator, 'money_talks/helpers/transaction_number_generator.rb'
  autoload :SoapObjectBuilder, 'money_talks/helpers/soap_object_builder.rb'
  autoload :SoapModel, 'money_talks/soap_model.rb'
  autoload :Payable, 'money_talks/payable.rb'
  autoload :Serializable, 'money_talks/serializable.rb'
  autoload :PSPAdapter, 'money_talks/psp_adapter.rb'
  autoload :PaymentBase, 'money_talks/payment_base.rb'
  
  # Exceptions
  autoload :PSPNotSupportedError, 'money_talks/errors.rb'
  autoload :FieldNotSupportedError, 'money_talks/errors.rb'

  module Adyen

    autoload :Adapter, 'money_talks/gateways/adyen/adapter.rb'

    module Payments
      autoload :Base, 'money_talks/gateways/adyen/payments/base.rb'
      autoload :CreditCard, 'money_talks/gateways/adyen/payments/credit_card.rb'
      autoload :Boleto, 'money_talks/gateways/adyen/payments/boleto.rb'
    end

  end

  class << self

    def gateway_adapter
      @gateway_adapter ||= MoneyTalks::PSPAdapter.instance
    end

    def configure
      begin
        yield gateway_adapter
      rescue NoMethodError => e
        raise FieldNotSupportedError, "The field #{e.name} is not supported by the provider #{gateway_adapter.to_s}"
      end
    end

  end

end
