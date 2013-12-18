module MoneyTalks
  class TransactionNumberGenerator
    class << self

      def generate(prefix="")

        code = prefix.downcase
        
        12.times do 
          code += rand(65..90).chr
        end

        code += "t"

        code += Time.now.strftime("%Y%m%d%H%M%S")

      end

    end
  end
end
