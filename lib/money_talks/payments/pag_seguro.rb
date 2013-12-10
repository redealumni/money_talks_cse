module MoneyTalks
  module Payment
    class PagSeguro
      
      REQUIRED_FIELDS = %w(merchant_account amount reference)

      RECOMMENDED_FIELDS = %w(shopper_ip shopper_email shopper_reference)

      OPTIONAL_FIELDS = %w(fraud_offset select_brand)



    end
  end
end

