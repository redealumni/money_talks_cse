MoneyTalks.build_payment do |payment|
  
  payment.merchant_account  = "QuerobolsaCOM"
  payment.reference = MoneyTalks::Helpers::TransactionNumberGenerator.generate(size: 8, prefix: "test", timestamp: true)
  payment.shopper_email = "joaodasilva@fake.com"
  payment.shopper_IP = "189.102.29.193"

  payment.amount do |amount|
    amount.currency = "BRL"
    amount.value = 1000
  end
  
  payment.shopper_name do |shopper|
    shopper.first_name = "João" 
    shopper.last_name = "Da Silva"
  end
  
  payment.billing_address do |billing_address|
    billing_address.city = "São Paulo"
    billing_address.country = "BR"
    billing_address.house_number_or_name = 999
    billing_address.postal_code = "04787910"
    billing_address.state_or_province = "SP"
    billing_address.street = "Roque Petroni Jr"
  end

  payment.selected_brand = "boletobancario_itau"
  payment.shopper_statement = "Aceitar o pagamento até 15 dias após o vencimento. Não cobrar juros.
  Não aceitar o pagamento com cheque"
  payment.social_security_number= "56861752509"
  
end
