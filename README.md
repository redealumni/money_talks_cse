# MoneyTalks

A simple interface for payment gateways that seamlessly integrate with
ActiveRecord. Hook up your provider and start __paying__!

## Installation

Add this line to your application's Gemfile:

    gem 'money_talks'

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install money_talks

## Usage

``` ruby

class Payment < ActiveRecord::Base

  include Payable
  
  gateway_provider :adyen


  # implement your callbacks

  def on_send_payment_success
    Proc.new do |resp|
      self.status = "gateway_ack"
      self.status_reason = resp.reason
      PaymentNotification.send_mail
    end
  end

  def on_send_payment_error
    Proc.new do |resp|
      self.status = "Error"
      self.status_reason = resp.reason
    end
  end



end

p = Payment.new
 
p.send_payment(on_success: p.on_send_payment_success, on_error: p.on_send_payment_error) do 
  merchant_account = "MyShop"
  amount = 100
  reference = MoneyTalks::TransactionNumberGenerator.generate
end

p.cancel_payment do

end

p.refund_payment do

end


```

### Supported Providers

Adyen, PagSeguro

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
