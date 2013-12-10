require 'rubygems'
require 'money_talks'

include MoneyTalks::Payable

gateway_provider 'adyen'

on_error = Proc.new {|response| puts response }
on_success = Proc.new {|response| puts response }

fake_payment_data = {
   merchant_account: "QueroBolsa",
   amount: 20,
   reference: MoneyTalks::TransactionNumberGenerator.generate("querobolsa")
}
   

pay(on_success: on_success, on_error: on_error) do |payment_data|
  
  payment_data.merchant_account = fake_payment_data[:merchant_account]
  payment_data.amount = fake_payment_data[:amount]
  payment_data.reference = fake_payment_data[:reference]

end
