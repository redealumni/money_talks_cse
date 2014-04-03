# encoding: utf-8
money_talks_path = File.dirname(__FILE__)
$LOAD_PATH.unshift(money_talks_path) unless $LOAD_PATH.include?(money_talks_path)

require 'savon'
require 'singleton'
require 'active_support/core_ext'

module MoneyTalks
  
  autoload :VERSION, 'money_talks/version.rb'
  autoload :EnvironmentParser, 'money_talks/environment_parser.rb'
  autoload :Payment, 'money_talks/payment.rb'
  autoload :Callbacks, 'money_talks/callbacks.rb'
  autoload :Notifiable, 'money_talks/notifiable.rb'
  autoload :HookMethods, 'money_talks/hook_methods.rb'

  autoload :Payable, 'money_talks/payable.rb'
  autoload :Serializable, 'money_talks/serializable.rb'
  autoload :Adapter, 'money_talks/adapter.rb'

  autoload :PSPNotSupportedError, 'money_talks/errors.rb'
  autoload :FieldNotSupportedError, 'money_talks/errors.rb'
  autoload :PaymentNotImplementedError, 'money_talks/errors.rb'

  module Helpers
    autoload :TransactionNumberGenerator, 'money_talks/helpers/transaction_number_generator.rb'
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
    
    def env
      @env
    end
 
    # Determines if we are in a particular environment
    #
    # @return [Boolean] true if current environment matches, false otherwise
    def env?(e)
      @env == e.to_sym
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

    def adapter
      @adapter
    end
    
    def configure(psp)
      begin
        adapter = load_adapter(psp)
        yield adapter if block_given?
      rescue NoMethodError => e
        raise FieldNotSupportedError, "Field #{e.name} is not supported by the provider #{psp.to_s}"
      rescue PSPNotSupportedError => e
        raise
      else
        return @adapter
      end
    end

    def load_adapter(psp)
      begin
        psp_const = psp.to_s.camelize 
        adapter = Object.const_get("MoneyTalks::PSP::#{psp_const}::Adapter").new
      rescue NameError => e
        raise PSPNotSupportedError, "Provider #{psp_const} not available. Implement it first"
      else
        return @adapter = Adapter.new(adapter)
      end
    end

    def build_payment(payment=nil, payment_method=nil, &block)
      payment = payment || Payment.new(payment_method)
      payment.extend adapter.payment_decorator
      payment.instance_eval &block
      payment
    end
    
    MoneyTalks.env= MoneyTalks::EnvironmentParser.parse(ARGV)

  end

end
