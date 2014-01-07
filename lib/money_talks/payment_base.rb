module MoneyTalks
  class PaymentBase

    def evaluate(&block)
      instance_eval &block
      self
    end

  end
end
