module MoneyTalks
  class FieldNotSupportedError < NoMethodError; end
  class PaymentNotImplementedError < NameError; end
  class AdyenError < StandardError

      def initialize(code, original_message)
        @code, @original_message = code, original_message
        super(MoneyTalks.translation[:errors][code])
      end

   end

end
