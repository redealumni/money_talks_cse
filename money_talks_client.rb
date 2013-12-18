require 'rubygems'
require 'money_talks'

MoneyTalks.configure do |config|
  config.payment_service_provider = "adyen"
  config.webservice_endpoint = "http://www.example.com"
  config.user = "felipe"
  config.password = "password"
end


include MoneyTalks::Payable

on_error = Proc.new {|response| puts response }
on_success = Proc.new {|response| puts response }

authorize(on_success: on_success, on_error: on_error) do |payment|
   
  payment.merchant_account  = "querobolsa"
  payment.reference = "287t34872gkasgra"
  
  payment.amount do |amount_data|
    amount_data.currency = "BRL"
    amount_data.value = 20
  end

  payment.fraud_offset = 10

  payment.payment_method :credit_card do |cc|
    cc.expiry_month = "12"
    cc.expiry_year = "2014"
    cc.holder_name = "John Doe"
    cc.number = "1111-2222-3333-4444"
    cc.cvc = "492"
  end

end
