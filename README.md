# MoneyTalks

A simple common interface for payment service providers. Don't let a specific vendor hold
you hostage. Payment gateway integration should not be
painful. MoneyTalks lets you attach vendor-specific code to your app 
and integrate seamlessly with ActiveRecord through a clean and simple interface.
If your provider is still not supported feel free to contribute

## Installation

Add this line to your application's Gemfile:

    gem 'money_talks'

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install money_talks

## Usage

First step you should ``include
Payable`` in your payment model. Now this model is enpowered with some simple and powerful methods. All you have to do is implement the necessary callbacks for each of them, so everything will be organized

## Rails

If you are using rails, first create this file insider your initializers folder money_talks.rb

```ruby

MoneyTalks.configure do |config|
  config.payment_service_provider = "gateway"
  config.endpoint = "http://www.gateway.com"
  config.user = "my_user"
  config.pass = "my_password"
end

```


``` ruby

class Payment < ActiveRecord::Base

  include Payable

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

## Debug/Console

Start the console `` ./money_talks --psp [psp. i.e adyen] --user [USER] --password [PASSWORD] ``

Your fixture object holds several objects that you can play along with

## Supported PSPs
1. Adyen

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
