MoneyTalks.build_payment do |payment|
  payment.merchant_account  = "QuerobolsaCOM"
  payment.reference = MoneyTalks::Helpers::TransactionNumberGenerator.generate(size:8)
  payment.shopper_email = "joaodasilva@fake.com"
  payment.shopper_IP = "189.102.29.193"
  payment.shopper_reference = "João da Silva"

  payment.amount do |a|
    a.currency = "BRL"
    a.value = 430098
  end

  payment.installments do |i|
    i.value = 2
  end
  
  payment.card do |card|
    card.expiry_month = "06"
    card.expiry_year = "2016"
    card.holder_name = "John Doe"
    card.number = "5555444433331111"
    card.cvc = "737"
  end
end
