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

  def on_pay_success
    Proc.new do |resp|
      self.status = "gateway_ack"
      self.status_reason = resp.reason
      PaymentNotification.send_mail
    end
  end

  def on_pay_error
    Proc.new do |resp|
      self.status = "Error"
      self.status_reason = resp.reason
    end
  end

  def on_cancel_success
  end

  def on_cancel_error
  end

  def on_refund_success
  end

  def on_refund_error
  end

end
```

```ruby


payment = Payment.new
 
payment.pay(on_success: p.on_send_payment_success, 
  on_error: p.on_send_payment_error) do |data|

  data.merchant_account = "MyShop"
  data.amount = 100
  data.reference = MoneyTalks::TransactionNumberGenerator.generate

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
