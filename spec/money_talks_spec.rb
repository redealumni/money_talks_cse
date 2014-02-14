require 'spec_helper'

describe MoneyTalks do

  describe '.psp_adapter' do

    it 'returns a singleton instance of gateway adapter' do
      psp_adapter = MoneyTalks::PSPAdapter.instance
      expect(subject.psp_adapter).to be_eql(psp_adapter)
    end

  end

  describe '.configure' do

    context 'with a valid configuration' do
      
      let(:valid_adapter) do

        subject.configure do |config|
          config.psp = :adyen
          config.user = "user"
          config.password = "password"
        end

        subject.psp_adapter

      end

      it 'sets the payment service provider' do
        expect(valid_adapter.psp).to be_an_instance_of MoneyTalks::Adyen::Adapter
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
              config.psp = "provider_not_supported"
            end
          }.to raise_error MoneyTalks::PSPNotSupportedError
        end

      end

      context 'when a payment service provider does not support a given field' do
        it "raises a FieldNotSupportedError" do
          expect{
            subject.configure do |config|
              config.psp = :adyen
              config.not_supported_field = "some_configuration"
            end
          }.to raise_error MoneyTalks::FieldNotSupportedError
        end
      end

    end

  end

end
