class Payment


  def initialize

  end

  def send

  end

  class << self

    def data(&block)
      payment = Payment.new
      payment.instance_eval(block)
      payment
    end

  end

end

include Payable

p.send(on_error: , on_success:) do |p|
  p.
end

def send do |p|
  yield b @gateway.payment_data
  @gateway.send_payment
end

payment_gateway: :adyen


payment = Payment.data do
  cpf
  name

  credit_card do
    number
    master
  end

end

payment.send
