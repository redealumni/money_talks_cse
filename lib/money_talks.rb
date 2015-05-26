# encoding: utf-8
money_talks_path = File.dirname(__FILE__)
$LOAD_PATH.unshift(money_talks_path) unless $LOAD_PATH.include?(money_talks_path)

require 'singleton'
require 'active_support'
require 'active_support/core_ext'
require 'savon'

module MoneyTalks

  autoload :VERSION,                    'money_talks/version.rb'
  autoload :EnvironmentParser,          'money_talks/environment_parser.rb'
  autoload :Payment,                    'money_talks/payment.rb'
  autoload :Callbacks,                  'money_talks/callbacks.rb'
  autoload :Notifiable,                 'money_talks/notifiable.rb'
  autoload :ClassMethods,               'money_talks/class_methods.rb'

  autoload :Serializable,               'money_talks/serializable.rb'
  autoload :AdyenClient,                'money_talks/adyen_client.rb'

  module ComplexTypes
    autoload :AdditionalData,           'money_talks/complex_types/additional_data.rb'
  end

  autoload :PSPNotSupportedError,       'money_talks/errors.rb'
  autoload :FieldNotSupportedError,     'money_talks/errors.rb'
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

    def client
      @soap_client
    end

    def configure(&b)
      @soap_client = MoneyTalks::AdyenClient.new
      @soap_client.instance_eval &b
      rescue NoMethodError => e
        raise FieldNotSupportedError, "Field #{e.name} is not supported"
    end

    def build_payment(binding_object=nil, payment=nil, &block)
      payment = payment || Payment.new
      payment.instance_exec payment, binding_object, &block
      payment
    end

    MoneyTalks.env= MoneyTalks::EnvironmentParser.parse(ARGV)

end

end
