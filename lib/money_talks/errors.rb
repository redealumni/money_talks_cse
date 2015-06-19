module MoneyTalks
  class FieldNotSupportedError < NoMethodError; end
  class PaymentNotImplementedError < NameError; end
  class AdyenError < StandardError

      attr_reader :code, :original_message

      def initialize(code, original_message)
        @code, @original_message = code, original_message
        super(MoneyTalks.translation[:errors][code])
      end

   end

end
