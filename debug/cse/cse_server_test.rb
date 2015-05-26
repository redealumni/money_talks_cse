require 'money_talks'
require 'pry'

system("source .env")

MoneyTalks::configure do |config|
  config.wsdl     = "https://pal-test.adyen.com/pal/servlet/Payment/v8?wsdl"
  config.user     = ENV['MONEY_TALKS_USER']
  config.password = ENV['MONEY_TALKS_PASSWORD']
end

class CSEServerTest < Sinatra::Base

  get '/' do
    File.read(File.join('public','cse_form.html'))
  end

  post '/create' do

    encrypted_data = params['adyen-encrypted-data']

    payment = MoneyTalks.build_payment do |payment|

      payment.merchant_account  = 'AkidogCOM'
      payment.reference = MoneyTalks::Helpers::TransactionNumberGenerator.generate({
        size: 5,
        timestamp: false,
        prefix: "dev-#{Socket.gethostname}::#{Time.now.strftime('%FT%T%:z')}"
      })
      payment.shopper_email     = 'johndoe@example.com'
      payment.shopper_IP        = '127.0.0.1'
      payment.shopper_reference = 'johndoe@example.com'

      payment.additional_data do |additional_data|
        additional_data.entry do |entry|
          entry.key   = 'card.encrypted.json'
          entry.value = encrypted_data
        end
      end

      payment.amount do |a|
        a.currency = "BRL"
        a.value    = 200
      end

    end.authorise

  end

end
