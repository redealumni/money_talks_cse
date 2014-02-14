# encoding: utf-8
money_talks_path = File.dirname(__FILE__)
$LOAD_PATH.unshift(money_talks_path) unless $LOAD_PATH.include?(money_talks_path)

require 'savon'
require 'singleton'
require 'active_support/core_ext'

module MoneyTalks
  
  autoload :VERSION, 'money_talks/version.rb'
  autoload :EnvironmentParser, 'money_talks/environment_parser.rb'
  autoload :TransactionNumberGenerator, 'money_talks/helpers/transaction_number_generator.rb'
  autoload :Payable, 'money_talks/payable.rb'
  autoload :Serializable, 'money_talks/serializable.rb'
  autoload :PSPAdapter, 'money_talks/psp_adapter.rb'
  autoload :AbstractPayment, 'money_talks/abstract_payment.rb'
  
  autoload :PSPNotSupportedError, 'money_talks/errors.rb'
  autoload :FieldNotSupportedError, 'money_talks/errors.rb'

  module Adyen

    autoload :Adapter, 'money_talks/psps/adyen/adapter.rb'
    autoload :Authorizable, 'money_talks/psps/adyen/operations/authorizable.rb'
   
    module Payments
      autoload :Base, 'money_talks/psps/adyen/payments/base.rb'
      autoload :Card, 'money_talks/psps/adyen/payments/card.rb'
    end

  end

  class << self

    ENVIRONMENTS = [:development, :test, :production]

    ENVIRONMENTS.each do |e|
      define_method "#{e}?" do
        env? e
      end
    end

    alias :prod? :production?
    alias :dev? :development?
    
    def psp_adapter
      @psp_adapter ||= MoneyTalks::PSPAdapter.instance
    end

    # Sets initial settings for the PSP adapter
    def configure
       MoneyTalks.env= MoneyTalks::EnvironmentParser.parse(ARGV)
      begin
        yield psp_adapter
      rescue NoMethodError => e
        raise FieldNotSupportedError, "Field #{e.name} is not supported by the provider #{psp_adapter.to_s}"
      end
    end
    
    def env
      @env
    end
 
    # Sets the current money_talks environment
    #
    # @param [String|Symbol] env the environment symbol
    def env=(e)
      @env = case(e.to_sym)
      when :dev  then :development
      when :prod then :production
      else e.to_sym
      end
    end

    # Determines if we are in a particular environment
    #
    # @return [Boolean] true if current environment matches, false otherwise
    def env?(e)
      env == e.to_sym
    end


  end

end
