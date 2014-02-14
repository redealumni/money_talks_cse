module MoneyTalks
  class TransactionNumberGenerator
    class << self

      
      
      def generate(prefix="", timestamp=false)

        code = "#{prefix.downcase}_"
        
        code += SecureRandom.hex(6)

        code += "_" + Time.now.strftime("%Y%m%d%H%M%S") if timestamp == true

        code

      end

    end
  end
end
