Proc.new do |payment|
  payment.merchant_account  = "QuerobolsaCOM"
  payment.reference = MoneyTalks::Helpers::TransactionNumberGenerator.generate("test@test.com")
  payment.shopper_email = "joaodasilva@fake.com"
  payment.shopper_IP = "189.102.29.193"
  payment.shopper_reference = "João da Silva"
  
  payment.amount do |amount_data|
    amount_data.currency = "BRL"
    amount_data.value = 430098
  end
  
  payment.installments do |i|
    i.value = 2
  end
  
  payment.card do |cc|
    cc.expiry_month = "06"
    cc.expiry_year = "2016"
    cc.holder_name = "John Doe"
    cc.number = "5555444433331111"
    cc.cvc = "737"
  end
end
