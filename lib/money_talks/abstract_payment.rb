module MoneyTalks
  class AbstractPayment

    def evaluate(&block)
      instance_eval &block
      self
    end

  end
end
