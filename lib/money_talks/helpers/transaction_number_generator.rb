module MoneyTalks
  module Helpers
    class TransactionNumberGenerator
      class << self

        # Generates an unique hexadecimal transaction number of size n
        # A prefix can be used to hold visible strings, such as emails, registration numbers
        # , which can visibly help you identify this number among others. 
        # If timestamp is true it can also be part of the number

        def generate(options={})

          code = options[:prefix] ? "#{options[:prefix].downcase}-" : ""
      
          code += SecureRandom.hex(options[:size]/2)

          code += "-" + Time.now.strftime("%Y%m%d%H%M%S") if options[:timestamp] == true

          code

        end

      end
    end
  end
end
