module MoneyTalks
  module Gateway
    class PagSeguro

      def payment
        ::Payment::PagSeguro.new
      end

      # return 
      def send_payment(callbacks={})
        raise NotImplementedError
      end

      def refund_payment(callbacks={})
        raise NotImplementedError
      end

      def cancel_payment(callbacks={})
        raise NotImplementedError
      end

      # informa o gateway que recebeu o post back
      def post_back_acknowledgment(token)
        raise NotImplementedError
      end

    end
  end
end

# ActiveRecord -> gateway_provider: :adyen
# 
# payment_provider: :adyen
#
#
# def send
#  payment = Payment.data do
#     cpf self.cpf
#     name "#{self.first_name} #{self.last_name}"
# 
#  end
#   payment.send
# end


#Payment.data do
#  cpf
#  amount
#  credit_card do
#     
#  end
#end

#Payment.data.cancel

#Payment.data do .refund

