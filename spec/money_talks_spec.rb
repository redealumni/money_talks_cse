require 'spec_helper'

describe MoneyTalks do

  describe '.gateway_adapter' do

    it 'returns a singleton instance of gateway adapter' do
      gateway_adapter = MoneyTalks::GatewayAdapter.instance
      expect(subject.gateway_adapter).to be_eql(gateway_adapter)
    end

  end

  describe '.configure' do

    context 'with a valid configuration' do
      
      let(:valid_adapter) do

        subject.configure do |config|
          config.payment_service_provider = :adyen
          config.webservice_endpoint = "http://fake.adyen.com"
          config.user = "user"
          config.password = "password"
        end

        subject.gateway_adapter

      end

      it 'sets the payment service provider' do
        expect(valid_adapter.payment_service_provider).to be_an_instance_of MoneyTalks::Gateway::Adyen
      end

      it 'sets the web service endpoint' do
        expect(valid_adapter.webservice_endpoint).to be_eql("http://fake.adyen.com")
      end

      it 'sets the user' do
        expect(valid_adapter.user).to be_eql("user")
      end

      it 'sets the password' do
        expect(valid_adapter.password).to be_eql("password")
      end

    end
    
    context 'with an invalid configuration' do

      context 'when payment service provider is invalid' do

        it "raises a PSPNotSupportedError" do
          expect {
            subject.configure do |config|
              config.payment_service_provider = "provider_not_supported"
            end
          }.to raise_error MoneyTalks::PSPNotSupportedError
        end

      end

      context 'when a payment service provider does not support a given field' do
        it "raises a FieldNotSupportedError" do
          expect{
            subject.configure do |config|
              config.payment_service_provider = :adyen
              config.not_supported_field = "some_configuration"
            end
          }.to raise_error MoneyTalks::FieldNotSupportedError
        end
      end

    end

  end

end
