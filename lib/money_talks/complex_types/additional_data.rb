module MoneyTalks
  module ComplexTypes
    class AdditionalData

      include Serializable

      attr_accessor :entry

      def entry(&block)
        return @entry unless block
        @entry ||= OpenStruct.new
        @entry.instance_eval(&block)
      end

    end
  end
end
