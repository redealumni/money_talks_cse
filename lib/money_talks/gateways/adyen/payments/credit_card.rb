module MoneyTalks
  module Adyen
    module Payments
      class CreditCard

        include MoneyTalks::SavonSerializationSupport

        attr_accessor :expiry_month, :expiry_year, :holder_name, :number,
          :cvc, :issue_number, :start_month, :start_year

        
      end
    end
  end
end
