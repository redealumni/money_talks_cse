# MoneyTalks

A simple common interface for payment service providers. Don't let a specific vendor hold
you hostage. Payment gateway integration should not be
painful. MoneyTalks provides a clean and simple interface which lets you seamlessly attach vendor-specific code 
for easy integration.

## Supported PSPs

If your provider is still not supported feel free to contribute. In the future psp specific implementation
will be bundled as a separate gem. See this link to understand how to create a provider specific gem

1. Adyen

## Installation

Add this line to your application's Gemfile:

    gem 'money_talks'

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install money_talks

## Rails

If you are using rails, first create the money_talks.rb file inside your initializers folder

## Environments

MoneyTalks will smoothly detect your ENV variables in order to set its own environment. 
In order it first checks RAILS_ENV, RACK_ENV and if none is set it will automatically set
the default environment to development


```ruby

MoneyTalks.configure :adyen do |config|
  config.user = "my_user"
  config.pass = "my_password"
  config.use_local_wsdl = true
end

```

## Support for Brazil

Adyen's current published live url doest not support installments! You can use the option
config.use_local_wsdl to use the correct WSDL


Building a payment is easy:

``` ruby

class Payment < ActiveRecord::Base


def authorize
  p = MoneyTalks.build_payment :credit_card do |payment|
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
    
    payment.card do |card|
      card.expiry_month = "06"
      card.expiry_year = "2016"
      card.holder_name = "John Doe"
      card.number = "5555444433331111"
      card.cvc = "737"
    end
  end

end


```

After building a payment you gain access to your provider operations

# Adyen

Pleasese note, for all modification requests Adyen will respond with a message appropriate to the modification type such
as captureReceived, cancelReceived or refundReceived. This message is an acknowledgment of your modification
request, it does not signify that the payment was actually modified. Once your request has been processed you will
receive a notification informing you whether or not the modification was
successful. note, for all modification requests Adyen will respond with a
message appropriate to the modification type such
as captureReceived, cancelReceived or refundReceived. This message is an acknowledgment of your modification
request, it does not signify that the payment was actually modified. Once your request has been processed you will
receive a notification informing you whether or not the modification was successful.


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
