Proc.new do |payment|
  payment.merchant_account  = "QuerobolsaCOM"
  payment.original_reference = "8513933390379853"
  payment.reference = MoneyTalks::Helpers::TransactionNumberGenerator.generate
  
  payment.modification_amount do |amount_data|
    amount_data.currency = "BRL"
    amount_data.value = 430098
  end
  
end

