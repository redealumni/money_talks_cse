module MoneyTalks
  # The default run environment, should one not be set.
  DEFAULT_ENV = :development
  
  class EnvironmentParser

    # The sources of environment, in increasing precedence, are:
    #
    #   1. Default (see MoneyTalks::DEFAULT_ENV)
    #   2. RAILS_ENV
    #   3. RACK_ENV
    #   4. -e/--environment command line options
    #
    # @param argv [Array] The command line arguments
    # @return [Symbol] The current environment
    def self.parse(argv = [])
      env = ENV["RAILS_ENV"] || ENV["RACK_ENV"] || MoneyTalks::DEFAULT_ENV
      if (i = argv.index('-e')) || (i = argv.index('--environment'))
        env = argv[i + 1]
      end
      env.to_sym
    end
  end

end
