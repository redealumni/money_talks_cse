require 'spec_helper'

describe MoneyTalks do

  describe '.configure' do

    context 'with a valid adapter' do
      it 'returns the adapter' do
        expect(MoneyTalks.configure(:adyen)).to be_an_instance_of MoneyTalks::Adapter
      end
    end

    context 'with an invalid adapter' do
      
      it "raises a PSPNotSupportedError" do
        expect {
          MoneyTalks.configure(:provider_not_supported)
        }.to raise_error MoneyTalks::PSPNotSupportedError
      end

    end
    context 'with a valid configuration' do
      
      let(:valid_adapter) do

        MoneyTalks.configure :adyen do |config|
          config.user = "user"
          config.password = "password"
        end

      end

      it 'sets the payment service provider' do
        expect(valid_adapter).to be_an_instance_of MoneyTalks::Adapter
      end

      it 'sets the user' do
        expect(valid_adapter.user).to be_eql("user")
      end

      it 'sets the password' do
        expect(valid_adapter.password).to be_eql("password")
      end

    end
    
    context 'with an invalid configuration' do

      context 'when a payment service provider does not support a given configuration' do
        it "raises a FieldNotSupportedError" do
          expect{
            MoneyTalks.configure :adyen do |config|
              config.not_supported_field = "some_configuration"
            end
          }.to raise_error MoneyTalks::FieldNotSupportedError
        end
      end

    end

  end

end
