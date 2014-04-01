module MoneyTalks
  class PSPNotSupportedError < NameError; end
  class FieldNotSupportedError < NoMethodError; end
  class PaymentNotImplementedError < NameError; end
end
