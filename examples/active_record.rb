class Payment < ActiveRecord::Base
  
  include Notifiable

  on_post_back :change_payment_status

  def self.build
    MoneyTalks.build_payment do |payment|
      payment.merchant_account  = "QuerobolsaCOM"
      payment.reference = MoneyTalks::Helpers::TransactionNumberGenerator.generate(size:8)
      payment.shopper_email = "joaodasilva@fake.com"
      payment.shopper_IP = "189.102.29.193"
      payment.shopper_reference = "João da Silva"
    end
  end

  def payment_handler
    self.class.build
  end

  def authorize
    payment_handler.authorize do |response|
      puts response
    end
  end

  def cancel
    payment_handler.cancel do |response|
      puts response
    end
  end

  def refund
    payment_handler.refund do |response|
      puts response
    end
  end

  def capture
    payment_handler.capture do |response|
      puts response
    end
  end

  def change_payment_status(post_msg)
    puts "Post back received from gateway: #{post_msg}"
  end



end

class CreditCard < Payment

  def self.build
    MoneyTalks.build_payment(super) do |payment|
      
      payment.amount do |a|
        a.currency = "BRL"
        a.value = 430098
      end

      payment.installments do |i|
        i.value = 2
      end
    
      payment.card do |cc|
        cc.expiry_month = "06"
        cc.expiry_year = "2016"
        cc.holder_name = "João da Silva"
        cc.number = "5555444433331111"
        cc.cvc = "737"
      end

    end
  end

end
