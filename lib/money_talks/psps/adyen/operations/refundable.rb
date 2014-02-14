module MoneyTalks
  module Adyen
    module Refundable
 
      def modification_amount
        @modification_amount ||= OpenStruct.new
        if block_given?
          yield @modification_amount
        else
          @modification_amount
        end
      end

      def refund
        { refund: { modification_request: Hash[self.instance_variables.map do |v|
              symbolized_key = v.to_s.gsub("@","").to_sym
              if self.instance_variable_get(v).kind_of? OpenStruct
                [symbolized_key, self.instance_variable_get(v).to_h]
              else
                [symbolized_key, self.instance_variable_get(v)]
              end
            end]
          }
        }
      end

    end
  end
end
