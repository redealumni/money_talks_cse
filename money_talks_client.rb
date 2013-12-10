require 'rubygems'
require 'money_talks'

include PayGem::Payable

gateway_provider 'adyen'

on_error = Proc.new {|response| puts response }
on_success = Proc.new {|response| puts response }

fake_payment_data = {
   merchant_account: "QueroBolsa",
   amount: 20,
   reference: MoneyTalks::TransactionNumberGenerator.generate("querobolsa")
}
   

send_payment(on_success: on_success, on_error: on_error) do
  
  merchant_account = fake_payment_data[:merchant_account]
  amount = fake_payment_data[:amount]
  reference = fake_payment_data[:reference]

end
