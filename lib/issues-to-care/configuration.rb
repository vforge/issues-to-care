module IssuesToCare
  # Stores runtime configuration information.
  #
  # Example settings
  #   IssuesToCare.configure do |c|
  #     c.username   = "vforge"
  #     c.repository = "bitpot"
  #
  #     c.api_key = "APIKEY"
  #     c.api_secret = "APISECRET"
  #   end
  class Configuration
    attr_accessor :username, :password, :repository, :api_key, :api_secret

    # Set default settings
    def initialize
      @username = nil
      @password = nil
      
      @repository = nil

      @api_key = nil
      @api_secret = nil

    end
  end
end
