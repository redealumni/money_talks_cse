# MoneyTalks

An easy interface for integration with common payment service providers. MoneyTalks abstracts many operations common
when working with PSPs, in a simple and easy interface.  Don't let a specific PSP hold you hostage anymore!!!

## Installation

Add this line to your application's Gemfile:

    gem 'money_talks'

Or install it yourself as:

    $ gem install money_talks

And finally execute:

    $ bundle install

__Important:__ You are only installing the adapter interface. We separated interface and vendor specific code as
different gems to provide a cleaner and lightweight code.

## Using a PSP

In order to do something useful with MoneyTalks, you need to attach a specific adapter, so MoneyTalks knows how to talk 
to your payment service provider. In this case all you need to do, is to include another gem, usually the format ``gem
'money_talks_[psp]'`` where __[psp]__  is the name of your payment service provider. Check the documentation here
in order to understand how you can implement you own providers.
Each payment service provider is bundled as a separate gem. 

## Supported PSPs

Currently, the following PSPs are supported:

1. Adyen | To use it add this line to your Gemfile `` gem 'money_talks_adyen' ``

If your provider is still not supported feel free to contribute.

## Getting Started

``` ruby
MoneyTalks.configure :adyen do |config|
  config.user = "my_user"
  config.pass = "my_password"
  config.use_local_wsdl = true
end

```

The ``use_local_wsdl`` parameter uses a local wsdl document, instead of a live version. This can be useful in some
cases.
In __Rails__, place this code inside a money_talks.rb file in your __initializers__ folder

### Environments

MoneyTalks will smoothly detect your ENV variables in order to set its own environment. 
In order of priority, it first checks RAILS_ENV, RACK_ENV and finally MONEY_TALKS_ENV

### Using MoneyTalks
Building a payment is very easy:

``` ruby

payment = MoneyTalks.build_payment :credit_card do |payment|
    
    payment.merchant_account  = "QuerobolsaCOM"
    payment.reference = MoneyTalks::Helpers::TransactionNumberGenerator.generate(size:8)
    payment.shopper_email = "joaodasilva@fake.com"
    payment.shopper_IP = "189.102.29.193"
    payment.shopper_reference = "João da Silva"
    
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

payment.authorize do |response|
  puts response
end

```

Typically, in a real world scenario, you will likely provide several payment methods. To avoid code duplication,
use can use the benefits of inheritance and put all your boilerplate code in a superclass.

``` ruby

class Payment < ActiveRecord::Base

  def self.build
    MoneyTalks.build_payment do |payment|
      payment.merchant_account = "QueroBolsaCOM"
      payment.reference = MoneyTalks::Helpers::TransactionNumberGenerator.generate(size:8)
    end
  end

  def payment_handler
    self.class.build
  end

end

class CreditCard < Payment

  def self.build
    MoneyTalks.build_payment(super, :credit_card) do |payment|
      payment.card do |cc|
        cc.expiry_month = "06"
        cc.expiry_year = "2016"
        cc.holder_name = "John Doe"
        cc.number = "5555444433331111"
        cc.cvc = "737"
      end
    end
  end

  def authorize
    payment_handler.authorize do |response|
      # do something
      # change the state machine
      # send an email to the customer about the payment status
    end
  end

  def cancel
    payment_handler.cancel do |response|
      # do something
    end
  end

  def capture
    payment_handler.capture do |response|
      # do something
    end
  end

  def refund
    payment_handler.refund do |response|
      # do something
    end
  end

end

```

## Handling Post Back Notifications

When you ``include Notifiable`` in your model, you gain access to a hook method called ``on_post_back``.  You can pass
either a method or a block to on_post_back which is executed whenever the ``notify`` method is called.
Usually PSPs processes your request asynchronously. After processing you request, a message is posted back to your
web site. Basically, with MoneyTalks, the following steps are taken:

  1. An operation over a payment is executed (i.e authorize, cancel, refund or capture)
  2. The PSP responds with a success or fail message(basically meaning that it has either received or not your message)
  3. The PSP enqueue your request, processes it and answers with a post back message (usually you setup the route
  in the PSP admin interface)
  4. The post request is received by your website and the ``notify`` method is called, passing the post message as a
     parameter
  5. The ``on_post_back`` callback is executed

Example using Rails

``` ruby

class PaymentNotificationsController < ApplicationController

  def create
    payment = Payment.find(params[:id])
    payment.notify(params[:post_payload])
  end

end

class Payment < ActiveRecord::Base

  include Notifiable
  
  on_post_back :do_something

  def do_something(post_payload)
    puts "Got a response from the gateway: #{post_payload}"
  end

end

```

For Rails, check a complete in __examples/rails__

## Debug/Console

Start the console `` ./money_talks --psp [psp. i.e adyen] --user [USER] --password [PASSWORD] ``

The options --load-fixtures will create a global array object called fixtures with access to several working/failing
objects

./money_talks

fixtures[0].authorize do |resp|

end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
