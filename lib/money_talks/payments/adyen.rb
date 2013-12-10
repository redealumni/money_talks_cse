module MoneyTalks
  module Payment
    class Adyen < Base
      
         REQUIRED_FIELDS = [:merchant_account, :amount, :reference]
      RECOMMENDED_FIELDS = [:shopper_ip, :shopper_email, :shopper_reference]
         OPTIONAL_FIELDS = [:fraud_offset, :select_brand]

      attr_accessor *(REQUIRED_FIELDS + RECOMMENDED_FIELDS)




    end
  end
end
