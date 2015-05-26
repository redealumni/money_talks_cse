require 'money_talks'

MoneyTalks::configure do |config|
  config.wsdl       = "https://pal-test.adyen.com/pal/servlet/Payment/v8?wsdl"
  config.cse        = true
  config.user       = ENV['MONEY_TALKS_USER']
  config.password   = ENV['MONEY_TALKS_PASSWORD']
  config.log_output = true
end

