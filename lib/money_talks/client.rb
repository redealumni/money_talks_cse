module MoneyTalks
  class Client

    class << self
      
      def adapter
        @adapter
      end
      
      def configure(psp)
        load_adapter(psp)
        begin
          if block_given?
            yield adapter
          else
            adapter
          end
        rescue NoMethodError => e
          raise FieldNotSupportedError, "Field #{e.name} is not supported by the provider #{psp.to_s}"
        end
      end

      private

      def load_adapter(psp)
        begin
          psp_const = psp.to_s.camelize; adapter = Object.const_get("MoneyTalks::#{psp_const}::Adapter").new
          @adapter ||= MoneyTalks::Adapter.new(adapter)
        rescue NameError => e
          raise PSPNotSupportedError, "Provider #{psp_const} not available. Implement it first"
        end
      end


    end

  end
end
