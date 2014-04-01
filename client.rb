def authorize
  MoneyTalks.build_payment do |payment|
    
    merchant_account  = "QuerobolsaCOM"
    reference = MoneyTalks::Helpers::TransactionNumberGenerator.generate(size: 16, timestamp: true)
    shopper_email = "joaodasilva@fake.com"
    shopper_IP = "189.102.29.193"

    payment.amount do
      currency = "BRL"
      value = 1000
    end
    
    payment.shopper_name do
      first_name = "João" 
      shopper.last_name = "Da Silva"
    end
    
    payment.billing_address do
      city = "São Paulo"
      country = "BR"
      house_number_or_name = 999
      postal_code = "04787910"
      state_or_province = "SP"
      street = "Roque Petroni Jr"
    end

    selected_brand = "boletobancario_itau"
    shopper_statement = "Aceitar o pagamento até 15 dias após o vencimento. Não cobrar juros.
    Não aceitar o pagamento com cheque"
    social_security_number= "56861752509"
  end.authorize(on_success: on_authorization_success, on_error: on_authorization_error)
end
