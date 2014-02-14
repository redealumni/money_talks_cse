require 'spec_helper'

describe MoneyTalks::EnvironmentParser do
  environment = [
                  ['production', 'development', 'production'],
                  [nil, 'production', 'production'],
                  [nil, nil, MoneyTalks::DEFAULT_ENV],
                ]

  environment.each do |rails_env,rack_env,output|
    context "when rails_env is #{rails_env.nil? ? 'not set' : rails_env.to_s} and rack_env is
    #{rack_env.nil? ? 'not_set' : rack_env.to_s}" do
      it "sets the environment to #{output}" do
        ENV['RAILS_ENV'], ENV['RACK_ENV'] = rails_env, rack_env
        expect(MoneyTalks::EnvironmentParser.parse).to eq(output.to_sym)
      end
    end
  end


end
