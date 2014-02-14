require 'rubygems'
require 'money_talks'

MoneyTalks.configure do |config|
  config.psp = :adyen
  config.user= "ws@Company.Querobolsa"
  config.password= "mFdPkXs#N8ng*c/5g/{r8}H9i"
end

include MoneyTalks::Payable

on_error = Proc.new {|response| puts response }
on_success = Proc.new {|response| puts response }

authorize(on_success: on_success, on_error: on_error) do |payment|
   
  payment.merchant_account  = "QuerobolsaCOM"
  payment.reference = MoneyTalks::TransactionNumberGenerator.generate("test@test.com")
  payment.shopper_email = "test@test.com"
  payment.shopper_ip = "123.123.123.123"
  payment.shopper_reference = "John Doe"

  payment.amount do |amount_data|
    amount_data.currency = "EUR"
    amount_data.value = 2000
  end

  payment.payment_method :card do |cc|
    cc.expiry_month = "12"
    cc.expiry_year = "2014"
    cc.holder_name = "John Doe"
    cc.number = "1111222233334444"
    cc.cvc = "492"
  end

end
